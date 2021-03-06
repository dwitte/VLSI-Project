import java.util.ArrayList;


public class Cell {
	private String name;
	private double xLocation, yLocation;
	private double height, width;
	private ArrayList<Pin> pins;
	private ArrayList<Net> nets;
	
	public Cell(String name, double x, double y, double height, double width)
	{
		this.name = name;
		xLocation = x;
		yLocation = y;
		this.height = height;
		this.width = width;
		pins = new ArrayList<Pin>();
		nets = new ArrayList<Net>();
	}
	
	public Cell(Cell cell1) {
		this.name = cell1.name;
		this.xLocation = cell1.xLocation;
		this.yLocation = cell1.yLocation;
		this.height = cell1.height;
		this.width = cell1.width;
		this.pins = cell1.pins;
		this.nets = cell1.nets;
	}

	public int cellCost()
	{
		int cost = 0;
		for(Net net : nets)
		{
			cost += net.cost();
		}
		return cost;
	}

	public void addNet(Net net)
	{
		nets.add(net);
	}
	
	public ArrayList<Pin> getPins() {
		return pins;
	}
	
	public ArrayList<Net> getNets() {
		return nets;
	}

	public void addPin(Pin in)
	{
		pins.add(in);
	}

	public double getxLocation() {
		return xLocation;
	}

	public void setxLocation(double xLocation) {
		this.xLocation = xLocation;
	}

	public double getyLocation() {
		return yLocation;
	}

	public void setyLocation(double yLocation) {
		this.yLocation = yLocation;
	}

	public String getName() {
		return name;
	}

	public double getHeight() {
		return height;
	}

	public double getWidth() {
		return width;
	}

	public void setNets(ArrayList<Net> nets2) {
		nets = nets2;
	}

	public void setPins(ArrayList<Pin> pins2) {
		pins = pins2;
	}

	public void setName(String name2) {
		name = name2;
	}
}
