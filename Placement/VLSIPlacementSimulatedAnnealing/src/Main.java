
public class Main {
	public static void main(String[] args) {
		SimulatedAnnealer sa = new SimulatedAnnealer(.99);
		Chip finalChip = sa.runSimulateAnnealer("../../chips/hack/netlists/And16.net", 500, 250);
		System.out.println("Finished");
	}

}
