import java.util.Random;


public class SimulatedAnnealer {
	private double alpha;
	
	public SimulatedAnnealer(double alpha)
	{
		this.alpha = alpha;
	}
	
	public Chip runSimulateAnnealer(String filename, int kMax, double startTemp)
	{
		Chip state = initializeChip(filename);
		Chip bestState = state;
		int cost = state.cost();
		int bestCost = cost;
		double temp = startTemp;
		
		int maxCost = state.cellCount()*(state.getHeight()+state.getWidth());
		int k = 0;
		while(k < kMax && cost < maxCost)
		{
			temp = temp * alpha;
			Chip newState = neighbour(state);
			int newCost = newState.cost();
			if(P(cost, newCost, temp) > randomPercentage())
			{
				state = newState;
				cost = newCost;
			}
			if(newCost < bestCost)
			{
				bestState = newState;
				bestCost = newCost;
			}
			k = k+1;
		}
		return bestState;
	}
	
	private Chip initializeChip(String filename)
	{
		return new Chip(filename);
	}
	
	private Chip neighbour(Chip state)
	{
		return state;
	}
	
	private double randomPercentage()
	{
		Random rand = new Random();
		return rand.nextDouble();
	}
	
	private double P(int cost, int newCost, double temperature)
	{
		return Math.exp(-(newCost-cost)/temperature);
	}
}