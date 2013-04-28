import java.util.ArrayList;


public class Cell {
	private String name;
	private double xLocation, yLocation;
	private double height, width;
	private ArrayList<Pin> inputs;
	private ArrayList<Pin> outputs;
	
	public Cell(String name, double x, double y, double height, double width)
	{
		this.name = name;
		xLocation = x;
		yLocation = y;
		this.height = height;
		this.width = width;
	}

	public void addInput(Pin in)
	{
		inputs.add(in);
	}
	
	public void addOutput(Pin out)
	{
		outputs.add(out);
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

	public ArrayList<Pin> getInputs() {
		return inputs;
	}

	public ArrayList<Pin> getOutputs() {
		return outputs;
	}
}
