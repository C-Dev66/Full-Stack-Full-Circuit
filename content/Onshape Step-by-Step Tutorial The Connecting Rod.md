
2025-04-29 20:45

Status: #adult

Tags: [[CAD]] [[MDA]] [[Onshape]] 

# Onshape Step-by-Step Tutorial The Connecting Rod

Following this tutorial will show me how to design a connecting rod used in an ICE vehicle. I expect to learn new shortcuts and features on Onshape. The purpose of this note is to document my experience and track useful shortcuts that will make my onshape workflow more efficient.

What I learned:

The goal of a sketch is to be fully defined. Allowing for the minus symbol to be removed from the tree view. If it has a minus sign that is a call for being under constrained or under defined.

Occasionally when modeling you will run into the situation where you want to focus on a specific section. It's more efficient to cut the model into sections to mirror in the future. 

In the case where the model is split, you can introduce what is called double dimension to create geometry for half the model that you will mirror later.  

When the part is complete you can introduce the Assembly Tab. Here is where you can bring multiple parts together an begin to assemble their final form. You can group and pair parts, and also bring them into the breakout view. Where the user can see how the part is assembled. 

| Tool            | Description                                                                                                                                                                                                                                               |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Sketch Mirror   | Select sketch entities and the diving plane to mirror onto the opposite side                                                                                                                                                                              |
| Dimension       | Select plane and a line to add a dimension. Best practice is to dimension against planes instead of sketch geometry. Should the sketch become tangled, exit the dimension tool and select the sketch and begin to untangle by moving the sketch geometry. |
| Extrude         | Can be performed multiple times from the same drawing. Configure the depth,  symmetry and merge all the extrusions to one part.                                                                                                                           |
| Edit Appearence | Right click the part and select edit appearance. Choose a color to paint the part.                                                                                                                                                                        |
| Split           | Split the part and specify on what plane and wether you want to keep both sides.                                                                                                                                                                          |
| Fillet          | Select to round a corner or edge between adjacent faces                                                                                                                                                                                                   |
| Revolve         | Will create a 3D solid around an axis, from a 2d sketch profile                                                                                                                                                                                           |
| Mirror          | Once you complete one side of a part, you can mirror onto the plane. Mirroring onto the front plane will do the opposite side.                                                                                                                            |
|                 |                                                                                                                                                                                                                                                           |




Shortcuts:

| Shorcut            | Description                                                                                                                                 |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| S                  | Brings up the shortcut menu. You can click a plane and then click S.                                                                        |
| N                  | Changes the view to "Normal To", perpendicular to your line of sight                                                                        |
| Q                  | Toggle construction geometry. Use after you click a sketch entity ex. Line, Circle etc.                                                     |
| I                  | Select a curve and a point and press I. This will create a coincidence relationship                                                         |
| Shift + Enter      | Repeat Last Command. Ex. Repeat Extrusion, common when you are using the same sketch to represent different values of extrusion.            |
| Shit + n           | To get into rename, click the feature first                                                                                                 |
| T                  | Select a circle and a line to make them Tangent                                                                                             |
| Extrude + Spacebar | When you select Extrude you can clear the default setting by pressing Spacebar                                                              |
| (~`)               | Pressing the (~`) tilde key will allow you to select an item behind the drawing. Use if the sketch, plane, or surface is getting in the way |
| P                  | Hide the planes                                                                                                                             |
| Shift + P          | Hide the planes and sketches, origin, and build geometry                                                                                    |


Summary:

###### References

https://www.youtube.com/watch?v=NbIwSzD9SHs

https://www.onshape.com/global-assets/documents/pdf-companion-onshape-30-minute-step-by-step-tutorial-the-connecting-rod.pdf

[[What is CAD (Computer Aided Design)?]]

[[How to use Onshape]]
