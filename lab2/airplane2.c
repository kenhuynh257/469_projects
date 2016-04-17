 // airplane.c

 /* This program computes velocity and flight time for an airplane flying 4781 miles
  * from London to Seattle. It computes average velocity without a headwind, and
  * flight duration with a headwind
  */

#include <stdio.h>

#define HEADWIND 89.6
#define MILES 4781

// Calculates velocity from the nominal flight
// time fixed flight distance.
float estimateVelocity(float time);
// Calculates flight time including a
// fixed headwind velocity.
float estimateTime (float velocity);

int main(int argc, char *argv[]) {
	float duration = 0;
	while(duration <= 0)
    {
        printf("How long is your flight in hours?\n");
        scanf("%f", &duration );
        if (duration <= 0) {
            printf("Flight time must be greater than 0 hours. Please enter a valid flight time.\n\n");
        }
    }
	float velocity = estimateVelocity(duration);
	estimateTime(velocity);
}

float estimateVelocity(float time) {
	float velocity = MILES / time;
	printf("Without headwind, the plane will be traveling %.2f miles per hour.\n", velocity);
	return velocity;
}

float estimateTime(float velocity) {
	float newvel = velocity - HEADWIND;
	float time = MILES / newvel;
	printf("With headwind, the flight will take %.2f hours.\n", time);
	return time;
}
