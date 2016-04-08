/* Write a function to prompt the user for the duration of a nonstop flight to
 * London from Seattle, in hours, as a floating point number.
 *
 * Based upon the number of air miles from Seattle to London, compute, then
 * write a second function print out the estimated velocity of the aircraft as
 * a floating point number.
 *
 * Using the velocity you computed and an estimated head wind of 89.6 miles per
 * hour, write a third function compute the estimated duration of the flight as
 * a floating point number.
 *
 * Finally write a fourth function to print the estimated flight duration.
 */
 
#define HEADWIND 89.6
#define MILES 4781
 
 
int main(int argc, char *argv[]) {
	float duration = 0;
	printf("How long is your flight in hours?\n");
	scanf("%f", &duration);
	float velocity = estimateVelocity(duration);
	estimateTime(velocity);
}

float estimateVelocity(float time) {
	float velocity = MILES / time;
	printf("Without headwind, the plane will be travelling %.2f miles per hour\n", velocity);
	return velocity;
}

float estimateTime(float velocity) {
	float newvel = velocity - HEADWIND;
	float time = MILES / newvel;
	printf("With headwind, the flight will take %.2f hours\n", time);
	return time;
}