
2025-09-25 21:07

Status: #child 

Tags: [[KiCAD]] [[PCB]] [[Design]] [[Electrical Engineer]] 

# KiCad 6 STM32 PCB Design Full Tutorial - Phil's Lab
The purpose of this write up is to document the first PCB Design I create on KiCad. The method in which I will achieve this is by following one of Phil's lab tutorials on Youtube. Below you will find a series of my notes and tips as I progress towards completing this project. The knowledge gained form this activity will serve as the foundation of my PCB "Know How" and support me in creating the Power Distribution Device (PDU) for Buckeye Space Launch Initiative (BSLI).

Topics Covered: 
1. [x] Schematic
	1. [x] STM32 Microcontroller, Decoupling
	2. [x] STM32 Configuration Pins
	3. [x] Pin-Out and STM32CubeIDE
	4. [x] Crystal Circuitry
	5. [x] USB
	6. [x] Power Supply and Connectors
	7. [x] Electrical Rules Check (CRC), Annotation
	8. [x] Footprint Assignment
2. [ ] Layout
	1. [ ] PCB Set-Up
	2. [ ] MCU, Decoupling Caps, Crystal Layout
	3. [ ] USB and SWD Layout
	4. [ ] Changing Footprints, Adding 3D Models
	5. [ ] Switch and Connector Placement
	6. [ ] Power Supply Layout
	7. [ ] Mounting Holes, Board Outline
3. [ ] Routing
	1. [ ] Decoupling, Crystal Routing
	2. [ ] Signal Routing
	3. [ ] Power Routing
	4. [ ] Finishing Touches, Design Rule Check (DRC)
4. [ ] Manufacturing
	1. [ ] Producing Manufacturing Files (BOM, CPL, Gerber, Drill)
Note: *Check items off as they're completed

Preliminary Requirements: 
To start off this tutorial I installed KiCad Ver.9.0.4 using Homebrew : 
```
brew install --cask kicad
```

To begin a PCB Design always start off with the **Schematic Editor**. Get accustomed to the mouse settings, then begin with dropping in your first component symbols. Start with the essentials of the board for example the Microcontroller (MCU). In this case we are using the **STM32F103C8T6**, you can search it in the **Choose Symbol** tool. Once the MCU is set continue with connecting your ground. Find the GND symbol in the **Chose Power Symbol** tool. A good rule of thumb, if there are grouped banks of ground or power using one symbol to connect all will save space and clean up your design. In 99% of all cases you want to tie together VSS(Digital) and VSSA(Analog) GND together. 

Once GND is set up, proceed with your Power. Look for +3.3V  in your **Choose Power Symbol** tool and connect your Power Pins VDD. ==Make a note later on we will have to consider decoupling capacitors, these are capacitors that will be placed very close to the MCU to provide a small pool of local energy storage.== This will help when the MCU switches and need quick transients of current, it cannot get that from the power supply because it goes through long leads. Also ==add in a Bulk Decoupling Capacitor used to handle larger, slower current transients that local decoupling caps can't support alone.== Once Decoupling Capacitors and Bulk Decoupling Capacitors are set, connect them all to GND. VDDA is for Analog circuits so typically you will require additional filtering done by a capacitor. The Analog portion will also required its own supply of +3.3VA, the A standing for Analog. ==Filtering can be done via a resistor, an inductor or ferrite bead. Ferrite bead acts like a resistor that dissipates head at high frequencies.== 

NRST pin contains an internal pull up resistor. If you will not be using using the pin, a good practice is to set a capacitor to prevent random resets. Give the connection a name by selecting the **Place Name Labels** menu and place the name on the line. PCB Layout will later be able to see this when connecting in the later steps. Set Net Labels as large as you can, and less critical labels to a much smaller font size. Setting the BOOT0 pin to high will enable you to write firmware to the MCU. This is important because we will have usb on the PCB that will be able to interface and flash  to the microcontroller. In default position the switch is set to Low (GND), to allow the current program to run. 

Future steps and value add, Connect a crystal oscillator that helps with timing. Think of it like the metronome of electronics, it keeps everything running in sync, on time, and at the right frequency. 

Software tool STM32CubeIDE will help us write the software and connect the correct drivers to flash the memory. Start new STM32 Project and select the MCU that you're using **STM32F103C8T6**, It will bring up a short feature summary confirm the specs, if all is OK proceed to Finish and Save. Pinout view will show a graphical summary of the chip on the left side of the screen the **categories** ribbon will show the features that can be enabled on the chip. For this example we want to enable **SYS**: Debug: Serial Wire, **RCC**: High Speed Clock (HSE) Crystal/Ceramic Resonator, **USB**: Device(FS). Once that is all set later on your will set up Clock Configuration. 

Once all the necessary pins are populated proceed to fix them in KiCad. Start off with **PD0** and **PD1** for the HSE (High Speed Clock) Crystal, **PA11** for USB_D-  and **PA12** for USB_D+ considered as the USB differential pair(==KiCad recognizes as a defferntial pair if you have the same name with + and -)== Then **PA13** for SWDI0 and **PA14** for SWCLK for serial debug. 

Reference for STM32 Microcontroller Oscillator Circuitry:
https://www.st.com/resource/en/application_note/an2867-guidelines-for-oscillator-design-on-stm8afals-and-stm32-mcusmpus-stmicroelectronics.pdf

Reference pg.11 for a recommended way to introduce the crystal. Set up with two load  capacitors to GND. Take the load capacitance of the crystal it self, subtract the stray capacitance (typically 3-5 (pF) picofarads). *A unit of capacitance, the measures an objects ability to store an electrical charge.* Then multiply that difference by 2. Set both load capacitance to 10(pF).


Reference for STM32 Microcontroller USB Hardware Guidelines:
https://www.st.com/resource/en/application_note/an4879-introduction-to-usb-hardware-and-pcb-guidelines-using-stm32-mcus-stmicroelectronics.pdf

Insert USB_B_Micro onto the drawing. Connect USB_D- and USB_D+, Set Pin 4 and Pin 6 with a (Do Not Connect Flag), and Pin 5 to GND Reference pg.3 of the manufactures recommend way to set up USB. According to the documentation, for STM32F1 series you will need to embed a pull up 1.5k Ohm resistor on USB_D+ line with 3.5V. When writing the value of 1.5k it's easier to read if you set as 1K5

Set up the serial wire debug connections to a Conn_01x04_Pin. The wiring goes as follows: Pin 1: +3.3V, Pin 2: SWDI0, Pin 3: SWCLK, Pin 4: GND. 

Reference for AMS1117 1A Low Dropout Voltage Regulator: 
https://jlcpcb.com/api/file/downloadByFileSystemAccessId/8550724073479806976

Linear Regulator AMS1117-3.3 will require input and output capacitors for stability set up to 22uF. Its advised to add some filtering when powering USB. For the sake of time we will not add. For test design add a power on LED, when the regulator is on and providing 3.3V it will power up the LED. Don't forget to add a Resistor. 

To assign additional pins head over to SMT32CubeIDE. We will configure USART1, select Mode: Asynchronous. To change the auto selected pin hit CNTRL and it will highlight other pin options. We're also adding I2C2.  Proceed to populate the pins over on KiCad, use the same connector for I/O Conn_01x04_Pin. Route Power and GND, for I2C2 it requires pull up resistors on each line SCL and SDA. 

For any of the pins you're not using add a Do Not Connect Flag. 

To clean up the schematic section off the most important areas with the **Draw Rectangles Tool**. Name each section by adding a **text box** and add a page name. Set a name on the drawing by selecting **Page Settings.** Here you can edit the issue date, title, revision etc... Add comments to specific functions of your PCB, add equations and reference notes. Finally to confirm that you've made all of the Annotations open the **Annotate Schematic** window and select Annotate. 

 Before you proceed lets check our schematic with the **Electrical Rules Checker** if there are any errors fix them before moving on. Then once again check the Pinouts and that the parts are available. 

Next we'll set up the footprints for each of the symbols. Select the **Assign Footprints** tool, adjust filters for: Use Symbols Footprint filters, Filter By Pin Count. Start of with Capacitors sized: 0805_2012Metric. The footprints will depend on whether you want to hand solder or if the manufacturing facility can mount the components. When you have a footprint selected you can view the model by selecting **View Selected Footprint**, and also the **3D Viewer.** Once all the symbols have footprints, Apply, Save Schematic & Continue. 

Once the schematic is complete move onto the PCB Editor. 

1st set up the layer stack ups (How many layers you'll have) via the **Board Setup**. For a 2 layer set up F.Cu (Font Circuit board) as signal, then B.Cu (Back Circuit Board) as the power plane. 


| Schematic Shortcuts     | Desc                                                         |
| ----------------------- | ------------------------------------------------------------ |
| W (Wire)                | Hover over a symbol Click W to connect to something          |
| M (Move)                | Hover over a symbol Click M to move the object around        |
| R (Rotate)              | With a symbol selected Click R to rotate                     |
| X & Y (Switch)          | Switch symbol is selected move the throws by pressing X or W |
| Q (Do Not Connect Flag) | Hover over a pin and select Q to set a do not connect Flag   |



## References

STM32 Blue Pill:
https://stm32-base.org/boards/STM32F103C8T6-Blue-Pill.html
