import java.io.IOException;
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
		
		int maxCost = state.cellCount()*(state.getHeight()+state.getWidth())*state.netCount();
		int k = 0;
		while(k < kMax && cost < maxCost)
		{
			temp = temp * alpha;
			//System.out.println(temp);
			Chip newState = neighbour(state);
			int newCost = newState.cost();
			double prob = (P(cost,newCost,temp));
			double perc = randomPercentage();
			//System.out.println(prob + ">" + perc);
			if(prob > perc)
			{
				//System.out.println(prob + ">" + perc);
				System.out.println(newCost + "\t" + temp);
				state = newState;
				cost = newCost;
			}
			else
			{
				System.out.println(cost + "\t" + temp);
			}
			if(newCost < bestCost)
			{
				bestState = newState;
				bestCost = newCost;
			}
			k = k+1;
			/*try {
				System.in.read();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		}
		return bestState;
	}
	
	private Chip initializeChip(String filename)
	{
		return new Chip(filename);
	}
	
	private Chip neighbour(Chip state)
	{
		Chip newState = new Chip(state);
		Random rand = new Random();
		int x1 = Math.abs(rand.nextInt()%(state.getWidth()/10));
		int y1 = Math.abs(rand.nextInt()%(state.getHeight()/10));
		int x2 = Math.abs(rand.nextInt()%(state.getWidth()/10));
		int y2 = Math.abs(rand.nextInt()%(state.getHeight()/10));
		
		newState.swap(x1, y1, x2, y2);
		
		return newState;
	}
	
	private double randomPercentage()
	{
		Random rand = new Random();
		return rand.nextDouble();
	}
	
	private double P(int cost, int newCost, double temperature)
	{
		return Math.exp(-(newCost-cost+1)/temperature);
	}
}
