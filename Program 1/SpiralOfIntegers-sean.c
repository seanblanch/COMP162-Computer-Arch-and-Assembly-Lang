// Sean Blanchard
// COMP162
// 9/14/18



// spiral of integers 0, 1, 2
// command line interface with user
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LINELIMIT 30
#define NUMLIMIT LINELIMIT-8
 char *comline,*number,*xchars,*ychars, *commaloc;


 size_t bufsize=LINELIMIT;


 size_t numsize=NUMLIMIT;


int whereis (int Position, int* Xval, int* Yval) // to be completed
  //Position (How many steps away from orgin we have to take
  // x + y val -> put coordinates p steps aways
  {
    *Xval = 0; *Yval = 0;                    //Orgin set up
    int sideLength = 1;                      //Counter for how many steps till we turn
                                            //SideLength will get larger by increments of 1
                                            //Increase when get to end of y direction
    int stepCounter = 0;                    // Track our position in spiral
    int posFlag = 1;                        // if take steps along the Y axis change posFlag
    int xyFlag = 1;                         // Operate on x or y

  //  printf("Start -- stepCounter: %i  Position: %i\n", stepCounter, Position );
    // Keep looping
    while (stepCounter < Position) {
    //  printf("loop: xyFlag = %i\n", xyFlag);
      if (xyFlag == 1) {  // xyFlag posiitive x axis
      //   printf("Operating on y\n" );
         if (posFlag == 1) { // posFlag shift along y axis
          //  printf("x is going left\n" );
            for (size_t i = 0; i < sideLength; i++) {
            //   printf("incrementing x\n" );
               *Xval += 1;
               stepCounter++;
            //   printf("Upper - X is increased by 1\n" );
            //   printf("stepCounter: %i  Position: %i\n", stepCounter, Position );
               if (stepCounter == Position)
                 return 1;
               } // end for
            } // end posFlag
        else { // other posFlag != 1
        //  printf("Operating on y\n" );
//          if (posFlag == 1) {
            for (int i = 0; i<sideLength; i++) {
            //  printf("decrementing x\n" );
              *Xval -= 1;
               stepCounter++;
            //  printf("Lower - X is increased by 1\n" );
            //  printf("stepCounter: %i  Position: %i\n", stepCounter, Position );
              if (stepCounter == Position)
                return 1;
              }
//            } // posFlag
          } // else
       } // xfFlag
          else { //x going left
        //    printf("x is going left\n" );
            if (posFlag == 1)   {
              for (int i = 0; i<sideLength; i++) {
                *Yval += 1;
                 stepCounter++;
            //    printf("stepCounter: %i  Position: %i\n", stepCounter, Position );
                if(stepCounter == Position)
                    return 1;
                }// for
             } // posFlag
             else {
          //    printf("x is going left\n" );
              for (int i = 0; i<sideLength; i++) {
                *Yval -= 1;
                 stepCounter++;
                if (stepCounter == Position)
                  return 1;
                } // for

            } // else
            sideLength++;
             posFlag *= -1;

          } // end else
          xyFlag *= -1;

  } // end while
//  printf("End -- stepCounter: %i  Position: %i\n", stepCounter, Position );
//  printf("Exiting whereis routine...\n");
  return 0;
} // end whereis


int whatsat (int X, int Y) // to be completed
{

  {
    int Xval = 0;
    int Yval = 0;                    //Orgin set up
    int sideLength = 1;                      //Counter for how many steps till we turn
                                            //SideLength will get larger by increments of 1
                                            //Increase when get to end of y direction
    int stepCounter = 0;                    // Track our position in spiral
    int posFlag = 1;                        // if take steps along the Y axis change posFlag
    int xyFlag = 1;
                                            // Operate on x or y

  if(X == 0 && Y == 0){
    return stepCounter;
  }


    while (stepCounter >= 0) {
      if (xyFlag == 1) {  // xy coordinates
         if (posFlag == 1) { // makes x go negative
            for (size_t i = 0; i < sideLength; i++) {
               Xval += 1;
               stepCounter++;

               if (Xval == X && Yval == Y)
               {
                 return stepCounter;
               }
               } // end for
            } // end posFlag
        else { // other posFlag != 1
//          if (posFlag == 1) {
            for (int i = 0; i<sideLength; i++) {
              Xval -= 1;
               stepCounter++;

              if (Xval == X && Yval == Y) {
                return stepCounter;
              }
              }
//            } // posFlag
          } // else
       } // xfFlag
          else { //x going left
            if (posFlag == 1)   {
              for (int i = 0; i<sideLength; i++) {
                Yval += 1;
                 stepCounter++;
                if(Xval == X && Yval == Y) {
                    return stepCounter;
                  }
                }// for
             } // posFlag
             else {
              for (int i = 0; i<sideLength; i++) {
                Yval -= 1;
                 stepCounter++;
                if (Xval == X && Yval == Y) {
                  return stepCounter;
                }
                } // for

            } // else
            sideLength++;
             posFlag *= -1;

          } // end else
          xyFlag *= -1;

  } // end while

  return 0;
} // end whatsat


}




int main()
{
 int P, x, y, i, go_on=1, command,N, cindex;

 comline=malloc(bufsize*sizeof(char));

 number=malloc(numsize*sizeof(char));

 xchars=malloc(numsize*sizeof(char));

 ychars=malloc(numsize*sizeof(char));

 while(go_on)

 {

 printf("Command: ");

 memset(comline,' ',bufsize);

 getline(&comline,&bufsize,stdin);

 if (memcmp(comline,"quit",strlen("quit"))==0) go_on=0;

 else if (memcmp(comline,"whereis",strlen("whereis"))==0)

 {

 strcpy(number,comline+strlen("whereis"));

 N=atoi(number);

 if (N<0) printf("Negative numbers not in spiral\n");

 else {

 i=whereis(N,&x,&y);

 printf("%d is at %d,%d\n",N,x,y);

 }

 }
 else if (memcmp(comline,"whatsat",strlen("whatsat"))==0)

 {

 // find comma index = C

 commaloc=strpbrk(comline,",");

 if (commaloc==NULL) printf("comma missing\n");
 else {

 // overwrite comma with null byte
 *commaloc=0;

 // copy first number to xchars
 strcpy(xchars,comline+strlen("whatsat"));

 // copy second number to ychars
 strcpy(ychars,commaloc+1);

 // convert strings to numbers
 x=atoi(xchars);

 y=atoi(ychars);

 // find contents of the spiral at x,y
 i=whatsat(x,y);

 if (i==-1) printf("co-ordinates out of range\n");

 else printf("%d is at %d,%d\n",i,x,y);

 }
 }
 else printf("invalid command %s\n",comline);
 }
 printf("Goodbye\n");
}
