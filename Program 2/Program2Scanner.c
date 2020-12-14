//Sean Blanchard
// Lab 2
//9/26/18

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define LINELIMIT 30
#define NUMLIMIT LINELIMIT-8

#define STACK_SIZE 5

size_t bufsize=LINELIMIT;
size_t numsize=NUMLIMIT;

int pointer = 0;
int stack[STACK_SIZE];
int inputAsInt;
char userInput [25];
char c;
int i;

//-------------
//Pushed on the stack
//-------------
void push(){
  if (pointer <= STACK_SIZE){
    stack[pointer] = inputAsInt;
    pointer++; // pointer is increased by one
  } // end of if
  else {
    printf("Error: Stack Overflow\n"); //User entered int but array is full
  } // end of else
} // end of push

//--------------------
//Pop the top stack item
//--------------------
void pop(){
  if (pointer != 0){
    pointer--; //lower the pointer to int on Stack
    stack[pointer] = 0; // retun a 0 to array
  }// end of if statement
  else { // pointer = 0 print pointer is Empty
    printf("Error:Stack Empty\n"); // Stack is empty
  } // end of else
} // end of pop

//---------------
//Clear the stack
//---------------
void clear(){
    pointer = 0; // change location of pointer to 0
} // end of clear

//------------------------
//Display the stack top down
//------------------------
void display(){
  if (pointer > 0){
    for (int count = pointer - 1; count >= 0; count--){ // Start at some i and decrease
      printf("%d\n", stack[count]);
    } // end for
  } // end if
} // end of display

//--------------------------
// = print the top stack item
//--------------------------
void equal(){
  if (pointer != 0){
    printf("%d\n", stack[pointer - 1]); // prints the top stack item
  } // end if
  else {
    printf("Error: Stack empty no value to print\n"); // checks if stack is empty
  } // end else
} // end of equal

//-------------------------------------------
// + Replace the top2 stack items by their sum
//-------------------------------------------
void sum(){
  if (pointer >= 2){ // use pointer -1 for y
    stack[pointer - 2] = stack[pointer - 2] + stack[pointer - 1]; //pointer -2 + pointer -1 to pointer -2
    pointer --; // move back one pointer
    stack[pointer] = 0; //clear the pointer item
    } // end if
  else {
    printf("Error, not enough operands\n");
  } // end of else
} // end of sum

//--------------------------------------------
// * Replace the top 2 stak items by their product
//--------------------------------------------
void product(){
  if (pointer >= 2){
    stack[pointer - 2] = stack[pointer - 2] * stack[pointer - 1];
    pointer --; // move back one pointer
    stack[pointer] = 0; // clear the pointer item
  } // end if
  else {
    printf("Error, not enough operands\n");
  } // end else
} // end of product

//---------------------------------------------------
// - Replace the top 2 stack items by their difference
//---------------------------------------------------
void difference(){
  if (pointer >= 2){
    stack[pointer - 2] = stack[pointer - 2] - stack[pointer - 1];
    pointer --; // move back one pointer
    stack[pointer] = 0; //clear the pointer item
  } // end if
  else {
    printf("Error, not enough operands\n");
  } // end else
} // end of difference

//-------------------------------------------------
// / Replace the top 2 stack items by their quotient
//-------------------------------------------------
void quotient(){
  if (pointer >= 2 && stack[pointer -1] != 0){
    stack[pointer - 2] = stack[pointer - 2] / stack[pointer - 1];
    pointer --; // move back one pointer
    stack[pointer] = 0; //clear the pointer item
  } // end if
  else {
    printf("Error, not enough operands, or attempt to divide by 0\n");
  } // end else
} // end quotient
// ^ Replace the top 2 stack items by second raised to the power top
void power(){
  if (pointer >= 2){
    stack[pointer - 2] = pow(stack[pointer - 2] , stack[pointer - 1]);
    pointer --; // move back one pointer
    stack[pointer] = 0; //clear the pointer item
  } // end if
  else {
    printf("Error, not enough operands\n");
  } // end else
} // end quotient



int main() {
  int goOn = 1; // goOn is true
 while (goOn) {

  printf("Command: ");
  scanf("%s", userInput); //scanner

  inputAsInt = atoi(userInput);

  if (inputAsInt != 0) {
    push(); // push
  }

  else // not a number
  {
    switch(userInput[0]) {
      //pop
      case 'p':
         pop();
         break;
         //quit
      case 'q':
         goOn = 0; // goOn is set to false
         //clear
      case 'c':
         clear();
         break;
         //display
      case 'd':
         display();
         break;
         //equal
      case '=':
         equal();
         break;
         //sum
      case '+':
         sum();
         break;
         //product
      case '*':
         product();
         break;
         //difference
      case '-':
         difference();
         break;
         //quotient
      case '/':
         quotient();
         break;
         //power
      case '^':
         power();
         break;
         //unrecognized command
      default:
         printf("Error: unrecognized command, %c\n", userInput[0]);
       } // end switch

     } // end else
   } // end  while loop
   printf("Goodbye");
} // end main
