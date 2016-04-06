/*
 *
 */

#include <stdio.h>
#include <math.h>

#define SOCIALSECURITY 10.3
#define FEDERALTAX 28

float socSec(float val);
float taxes(float val, float state);

int main(int argc, char *argv[]) {
  float salary;
  float stateTax;

  printf("What is the starting salary offer?\n");
  scanf("%f", &salary);
  printf("What is the state income tax? If the state does not have an income tax, use 0.\n");
  scanf("%f", &stateTax);

  salary = socSec(salary);
  salary = taxes(salary, stateTax);
  salary = roundf(salary * 100) / 100;
  printf("Your expected salary is $%.2f\n", salary);
  return 0;
}

float socSec(float val) {
  float rem;

  if (val >= 65000) {
    rem = (65000 * SOCIALSECURITY) / 100;
  } else {
    rem = (val * SOCIALSECURITY) / 100;
  }

  return val - rem;
}

float taxes(float val, float state) {
  float rem = 3500;

  if (val > 30000) {
    rem += (((val - 30000) * FEDERALTAX) / 100);
  }

  rem += ((val * state) / 100);
  return val - rem;
}
