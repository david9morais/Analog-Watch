/*******************************************************************************
*
*  Draft Processing code for the first assignment of the 'Introduction to
*  Computer Graphics' laboratory course.
*
*******************************************************************************/

// Current time
int hours = 0;
int minutes = 0;
int seconds = 0;

// Styling; the valu below are used in the example video
float minuteMarkLength = 50.0f; // length of the minute ticks; the difference
                                // between the start and end radii used to
                                // compute the start and end points of line
float hourMarkLength = 100.0f; // Same for the hour ticks
float hourHandLength = 170.0f; // Same for the hour hand
float minuteHandLength = 210.0f; // Same for the minute hand
float secondHandLength = 250.0f; // Also the same for the second hand
float numberPosition = 275.0f;

float tickMarkWeight = 8.0f; // weight for the ticks; used with strokeWeight()
float hourHandWeight = 12.0f; // weight for the hour hand
float minuteHandWeight = 12.0f;  // weight for the minute hand
float secondHandWeight = 6.0f;  // weight for the second hand
float numberSize = 25.0f;

color bgColor = color(0); // background color
color tickMarkNumberColor = color(255);
color tickMarkColor = color(20, 75, 200); // color for the tick marks; used with stroke()
color hourHandColor = color(255); // color for the hour hand
color minuteHandColor = color(20, 75, 200); // color for the minute hand
color secondHandColor = color(255, 0, 0); // color for the second hand
color numberColor = color(255);

float radius = 400;
float centerX;
float centerY;
float clockDiameter = radius * 2;

void setup()
{
    // Init our window
    size(800, 800);

    // Set the frame rate
    frameRate(60);
    
    centerX = width / 2;
    centerY = height / 2;
    
    // Draw the first frame
    draw();
}

PVector convertAndTranslate(float theta, float r){
  theta -= HALF_PI;
  return new PVector(r * cos(theta) + centerX, r * sin(theta) + centerY);
}

void draw()
{
    // Extract the current time
    seconds = second();
    minutes = minute();
    hours = hour()% 12;

    // Clear the canvas with the default background color
    background(bgColor);
        
    // draw the dial (minute and hour ticks) here
    for(int i = 0; i <60; i++){
     strokeCap(ROUND);
        if(i % 5 == 0){
          strokeWeight(tickMarkWeight);
          stroke(tickMarkNumberColor);
          float x0 = centerX + (centerX - hourMarkLength) * cos(i * ((2 * PI) / 60));
          float y0 = centerY + (centerX - hourMarkLength) * sin(i * ((2 * PI) / 60));
          float x1 = centerX + (centerX) * cos(i * ((2 * PI) / 60));
          float y1 = centerY + (centerX) * sin(i * ((2 * PI) / 60));
          line(x0, y0, x1, y1);
        }else{
          strokeWeight(tickMarkWeight);
          stroke(tickMarkColor);
          float x0 = centerX + (centerX - minuteMarkLength) * cos(i * ((2 * PI) / 60));
          float y0 = centerY + (centerX - minuteMarkLength) * sin(i * ((2 * PI) / 60));
          float x1 = centerX + (centerX) * cos(i * ((2 * PI) / 60));
          float y1 = centerY + (centerX) * sin(i * ((2 * PI) / 60));
          line(x0, y0, x1, y1);
        }
    }
    
    // draw the second, minute and hour hands here
    float xs = centerX + (secondHandLength * cos( - HALF_PI + (seconds * ((2 * PI) / 60))));
    float ys = centerY + (secondHandLength * sin( - HALF_PI + (seconds * ((2 * PI) / 60))));
    float xm = centerX + (minuteHandLength * cos( - HALF_PI + (minutes * ((2 * PI) / 60))));
    float ym = centerY + (minuteHandLength * sin( - HALF_PI + (minutes * ((2 * PI) / 60))));
    float xh = centerX + (hourHandLength * cos( - HALF_PI + map(hours + norm(minute(), 0, 60), 0, 12, 0, TWO_PI)));
    float yh = centerY + (hourHandLength * sin( - HALF_PI + map(hours + norm(minute(), 0, 60), 0, 12, 0, TWO_PI)));
    
    strokeCap(PROJECT);
    stroke(secondHandColor);
    strokeWeight(secondHandWeight); 
    line(centerX, centerY, xs, ys);
    stroke(minuteHandColor);
    strokeWeight(minuteHandWeight);
    line(centerX, centerY, xm, ym);
    stroke(hourHandColor);
    strokeWeight(hourHandWeight);
    line(centerX, centerY, xh, yh);
    
    //draw the numbers
    for(int number = 1; number <= 12; number++){
      float theta = TWO_PI * (number / 12.0);
      PVector endPoint = convertAndTranslate(theta, numberPosition);
      text(Integer.toString(number), endPoint.x, endPoint.y);
      textSize(numberSize);
      textAlign(CENTER, CENTER);
      fill(numberColor);
    }
    
    noFill();
    ellipse(centerX, centerY, clockDiameter, clockDiameter);
}
