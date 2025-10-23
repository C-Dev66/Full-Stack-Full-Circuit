
2025-10-12 02:18

Status: #child 

Tags: [[BSLI]] [[RaspberryPi]] [[Networking]] [[Server]] [[Homelab]] [[DAQ]] [[SSH]] [[Database]] [[Docker]] [[Rocketry]]

# BSLI Raspberry Pi Data Acquisition Server

The purpose of this document is to record the process of setting up the Buckeye Space Launch Initiative – Team Liquid Raspberry Pi Data Acquisition Server. The system’s goal is to host a MySQL database that collects and manages all data logged from the LabJack DAQ system, and to serve this data to Grafana for visualization and to Ignition SCADA for supervisory control and monitoring.
### **System Overview**

The setup utilizes **two Raspberry Pi 5 units** connected through a **network switch**:

- **Raspberry Pi #1:**
    - Runs **DNSmasq** to assign IP addresses to all devices on the LAN.
    - Hosts **Docker containers** for the **MySQL database** and supporting services.
    - Managed via **Portainer** for container orchestration and monitoring.
- **Raspberry Pi #2:**
    - Dedicated to running **Ignition SCADA**.
    - Publishes acquired data to Raspberry Pi #1 for storage and visualization.
### **Network Configuration Notes (Mac + Raspberry Pi LAN)**

- Having **Wi-Fi and Ethernet active simultaneously** on macOS does **not cause issues**.
- The two interfaces can be **separated easily using different IP ranges**.
- For a **Pi-only LAN** connected through a switch, assign **static IPs** to both your Mac and the Raspberry Pi.

**Example Network Configuration:**

| **Interface** | **Device**   | **IP Address** | **Subnet Mask** | **Router**      |
| ------------- | ------------ | -------------- | --------------- | --------------- |
| Wi-Fi         | Mac          | (automatic)    | (as assigned)   | (gateway)       |
| Ethernet      | Mac          | 192.168.10.1   | 255.255.255.0   | _(leave blank)_ |
| Ethernet      | Raspberry Pi | 192.168.10.2   | 255.255.255.0   | _(leave blank)_ |
#### **macOS Configuration Steps**

1. Go to **System Settings → Network**.
2. Select your Ethernet interface (e.g., _USB 10/100/1000 LAN_).
3. Click **Details → TCP/IP**.
4. Set **Configure IPv4** to **Manually**.
5. Enter the following:
    - **IP Address:** 192.168.10.1
    - **Subnet Mask:** 255.255.255.0
    - **Router:** _(leave blank)_
6. Apply changes.

### **Raspberry Pi Network Configuration**

using nmtui
1. Open the terminal and run:
```
sudo nmtui
```

2. Navigate to **Edit a Connection → Wired Connection → IPv4 Configuration**.
3. Select **Manual** and set:
    - Address: 192.168.10.2/24
    - Gateway: _(leave blank)_
    - DNS: (leave blank)
4. Save and exit.
5. Apply changes with:
```
sudo systemctl restart NetworkManager
```

### **Testing SSH Connectivity**

1. **Enable SSH on the Raspberry Pi:**
```
sudo raspi-config
```

1. - Navigate to **Interfacing Options → SSH → Enable → Yes**.
    - Exit and reboot if prompted.
2. **From your Mac (or another host):** 
```
ssh (UserName)@192.168.10.2
```

### **Install Docker**

  
Once SSH access is verified, install Docker to enable containerized service management. Docker will host:
- **MySQL Database**
- **Grafana Visualization Stack**
- Other supporting applications

Container management will be handled via **Portainer**, providing a simple and intuitive web interface for monitoring and deployment.

**Comparison:**
- **Portainer**: User-friendly GUI for managing containers.
- **Dockage**: Lightweight alternative, but with fewer features and less integration support.

| **Feature**        | **Portainer**                                                                          | **Dockage**                                                                         |
| ------------------ | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Ease of Setup**  | Easy, but requires manual Docker install and setup                                     | Extremely easy — comes preconfigured with Docker tools                              |
| **Interface & UX** | Clean, modern, very intuitive                                                          | Uses Portainer’s interface since it includes it                                     |
| **Features**       | Deep control over containers, volumes, images, networks, stacks, users, and registries | Offers the same Portainer interface plus reverse proxy and network management tools |
| **Scalability**    | Excellent — supports **multi-node**, **Swarm**, and **Kubernetes** environments        | Limited — mainly designed for **single-host** setups                                |
| **Extensibility**  | Integrates with APIs, CI/CD tools, RBAC, LDAP, and external registries                 | Good for personal automation, but less modular                                      |
| **Resource Usage** | Lightweight                                                                            | Slightly heavier since it runs additional services (Traefik, monitoring, etc.)      |
| **Best Use Case**  | Professional environments, production clusters, multi-host setups                      | Personal labs, testing, self-hosted apps, and small networks                        |
| **Learning Curve** | Moderate — ideal for DevOps and IT professionals                                       | Low — great for beginners and hobbyists                                             |

---

### **Network Prerequisites for DNSmasq**


Before configuring **DNSmasq**, ensure the following:

1. The **eth0 interface** on Raspberry Pi #1 has a **static IP address** (e.g., 192.168.10.2).
2. The **LAN subnet** (e.g., 192.168.10.0/24) is **different from the Wi-Fi subnet** (e.g., 192.168.1.0/24) to avoid conflicts.

##  **Step 1: Install** **dnsmasq**
1. Install Dnsmasq (if not already installed)

```
sudo apt update
sudo apt install dnsmasq
```

2. Create a Custom Configuration File

t’s best practice to leave the main configuration file (/etc/dnsmasq.conf) untouched and instead create a custom configuration in the /etc/dnsmasq.d/ directory.

```
sudo vim /etc/dnsmasq.d/local.conf
```
3. Add the Interface-Specific Configuration

Add the following lines to the empty local.conf file.

This configuration ensures the Raspberry Pi handles DHCP and local DNS for the 192.168.10.x network but does not provide a path to the internet or forward any external queries.

```
# Core Configuration
interface=eth0
bind-interfaces

# Set the Raspberry Pi as the sole DHCP authority
dhcp-authoritative

# DHCP Range and Lease Time
# Note: The RPi's static IP (192.168.10.2) must be excluded from this range.
dhcp-range=192.168.10.100,192.168.10.200,255.255.255.0,12h

# DHCP Option 3: Router/Gateway
# REMOVED. By omitting this line, clients will not be told of a gateway, 
# preventing them from attempting to reach the internet.

# DHCP Option 6: DNS Server
# Set the DNS server option to the RPi's static IP (192.168.10.2)
dhcp-option=6,192.168.10.2

# DNS Configuration for Isolation
# 1. Block all external forwarding
no-resolv
server=
# 2. Disable listening for external/upstream servers (you can omit 8.8.8.8 and 1.1.1.1)

# Local Hostname Resolution
# Dnsmasq resolves names from /etc/hosts and DHCP leases.
domain-needed
bogus-priv

# Ensure the local domain (for DHCP assigned hosts) is defined
# This is usually optional but good practice for internal-only networks.
local=/lan/

# Caching (Still enabled for speed on repeat local queries)
cache-size=1000

```

# **Checking dnsmasq Server Logs and DHCP Leases**

## **Step 1. Verify dnsmasq Service Status**

First, confirm that dnsmasq is running correctly on your Raspberry Pi and is bound to the correct interface (eth0).

Run:
```
sudo systemctl status dnsmasq
```

You should see the following output:
```
Active: active (running)
```

and a Loaded line pointing to your configuration file (for example /etc/dnsmasq.d/local.conf or /etc/dnsmasq.d/lan.conf).

If the status shows **inactive**, **failed**, or **error**, check your configuration syntax and network interface settings before continuing.

## **Step 2. Monitor Logs for Real-Time Activity**

You can monitor live dnsmasq activity — such as DHCP requests and leases — using:
```
sudo journalctl -u dnsmasq -f
```
Keep this terminal open while connecting new devices to the network. You should see log entries each time a device requests or receives an IP address.

## **Step 3. View Current DHCP Leases**

The dnsmasq lease file stores all devices that have received an IP address. This file helps confirm that clients are successfully connecting and receiving leases.
### **Locate the Lease File**

Common lease file paths include:
```
/var/lib/misc/dnsmasq.leases
/var/lib/dnsmasq/dnsmasq.leases
/var/run/dnsmasq.leases
```

On most Raspberry Pi OS installations, the default location is:
```
sudo vim /var/lib/misc/dnsmasq.leases
```
You’ll see a list of active DHCP leases.

## **Step 4. Understanding the Lease File**

Each line in the lease file represents one active client and typically follows this structure:

| **Field**        | **Description**                                      | **Example Value** |
| ---------------- | ---------------------------------------------------- | ----------------- |
| **Lease Expiry** | Time (in seconds since epoch) when the lease expires | 1665561600        |
| **MAC Address**  | Device’s physical hardware address                   | b8:27:eb:aa:bb:cc |
| **IP Address**   | IPv4 address assigned to the device                  | 192.168.10.101    |
| **Hostname**     | Device’s hostname (if provided)                      | my-laptop         |
| **Client ID**    | Unique client identifier (sometimes *)               | *                 |

## **Step 5. Interpreting the Output**

By reading this output, you can quickly identify:

- Which devices are currently connected to your local network
- The **IP address**, **MAC address**, and **hostname** of each device
- When each lease will expire

This is useful for verifying that your dnsmasq DHCP server is functioning correctly and assigning addresses within your intended subnet (e.g., 192.168.10.x).


## References

Dnsmasq:
https://thekelleys.org.uk/dnsmasq/doc.html

Grafana:
https://grafana.com/docs/

Installing Docker on the Raspberry Pi
https://pimylifeup.com/raspberry-pi-docker/

Installing Portainer to the Raspberry Pi
https://pimylifeup.com/raspberry-pi-portainer/

How to Set Up a Static IP Address on the Raspberry Pi
https://pimylifeup.com/raspberry-pi-static-ip-address/
https://www.youtube.com/watch?v=qy1_jV1fgJU