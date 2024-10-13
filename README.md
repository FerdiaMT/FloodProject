# FloodProject
A first year project for Maynooth University finished in December 2023

<h1>About this project<h1>
<hr>
<h5>This was my first semester project for Maynooth Universitys Computer Science and Software Engineering course.</h5>
<h5>We were given a theme and a month to use our basic java skills.</h5>
<h5>The theme was <b>Enviroment</b>.</h5>
<h5>We had to use a graphics library called <a href = "https://processing.org">Processing</a>.</h5>
<h5>This project gave me a 89%  result in the module.</h5>
<hr>

<h5>Personally, I was not a big fan of both the theme and the software , although i would end up using the JavaScript version of processing for a different project.</h5>
<h5>I decided to make a simulation of Irelands coastline slowly flooding due to rising sea levels from global warming, which was probably the most morbid project idea anyone came up with.</h5>
<h5>I made the program by converting an elevation map of ireland to a black and white "reference image", in which the current sea level was painted black, with the image becoming more white as the elevation increased.</h5>
<h5>The program then scans the image, and slowly increases the sea level threshold, painting the image blue if under the threshold and green if over.</h5>
<h5>The sea level increase was calculated using the <a href = "https://sealevel.nasa.gov/ipcc-ar6-sea-level-projection-tool?type=global">RCP projections</a>, and can be increased or decreased depending on what the user wants to see.</h5>
<h5>As a disclaimer, my project is obviously not an obvious projection whatsoever, since it ignores all variables except for elevation levels of Ireland, the project was done out of interest on the subject and to produce an interesting result, which i belive it has.</h5>

<hr>
<h1>How to install</h1>
<h5>First you will need to install <a href = "https://processing.org">Processing</a>, a java graphics library, you will also need to have java installed on your system.</h5>
<h5>Once processing is installed, download the zip file of this project, unzip it, and open the sketch file in processing.</h5>
<h5>This project uses the Controlp5 Library for GUI elements , to install it in processing go to sketch --> import library --> manage libraries, then search controlp5 and install it.</h5>
<h5>After the library has installed, press play and the window shall appear.</h5>
