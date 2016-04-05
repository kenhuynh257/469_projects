/*
 *
 */

#include <stdio.c>

#define SOCIALSECURITY 10.3
#define FEDERALTAX 28

double round(double val);
double socSec(double val);
double taxes(double val, double state);

int main(int argc, char *argv[]) {
  double salary;
  double stateTax;
  
  printf("What is the starting salary offer?\n");
  scanf("%d", &salary);
  printf("What is the state income tax? If the state does not have an income tax, use 0.\n");
  scanf("%d", &stateTax);
  
  salary = socSec(salary);
  salary = taxes(salary, stateTax);
  salary = round(salary);
  printf("Your expected salary is $%d\n", salary);
}

double round(double val) {
  val = val * 100;
  val = val - (val % 1);
  val = val / 100;
  return val;
}

double socSec(double val) {
  double rem;
  
  if (val >= 65000) {
    rem = (65000 * SOCIALSECURITY) / 100;
  } else {
    rem = (val * SOCIALSECURITY) / 100;
  }
  
  return val - rem;
}

double taxes(double val, double state) {
  double rem = 3500;
  
  if (val > 30000) {
    rem += (((val - 30000) * FEDERALTAX) / 100);
  }
  
  rem += ((val * state) / 100);
  
  return val - rem;
}