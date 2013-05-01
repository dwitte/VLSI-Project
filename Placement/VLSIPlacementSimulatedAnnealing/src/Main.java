public class Main {
	
	public static void main(String[] args) {
		SimulatedAnnealer sa = new SimulatedAnnealer(.999);
		Chip finalChip = sa.runSimulateAnnealer("../../chips/hack/netlists/And16.net", 3500, 10000);
		System.out.println("Finished");
		
	}
}
