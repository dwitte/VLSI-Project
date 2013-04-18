//This program will be the part of the program that places the components onto the chip.
//Each of hte components are currently assumed to be the same size, to simplify the algorithm at this point.
//This portion uses simulated annealing to reach a near optimal solution to minimizing the distances between components.

//Future modifications:
/* 	-Handle multiple sizes of components
		-Requires reading the sizes of components
	-Handle various carrying capacities of cells
*/

struct State {

};

int main()
{

}

simulatedAnnealing()
{
/* Pseudo Code from wikipedia's page on Simulated Annealing
s ← s0; e ← E(s)                                  // Initial state, energy.
sbest ← s; ebest ← e                              // Initial "best" solution
k ← 0                                             // Energy evaluation count.
while k < kmax and e > emax                       // While time left & not good enough:
  T ← temperature(k/kmax)                         // Temperature calculation.
  snew ← neighbour(s)                             // Pick some neighbour.
  enew ← E(snew)                                  // Compute its energy.
  if P(e, enew, T) > random() then                // Should we move to it?
    s ← snew; e ← enew                            // Yes, change state.
  if enew < ebest then                            // Is this a new best?
    sbest ← snew; ebest ← enew                    // Save 'new neighbour' to 'best found'.
  k ← k + 1                                       // One more evaluation done
return sbest                                      // Return the best solution found.
*/
}
