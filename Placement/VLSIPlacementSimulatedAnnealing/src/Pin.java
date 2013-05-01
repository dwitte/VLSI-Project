
public class Pin {
	public int x, y;
	private String name;
	private String type; //TODO: Create into an Enum.
	
	public Pin(String name, String type, int x, int y)
	{
		this.name = name;
		this.x = x;
		this.y = y;
		this.type = type;
	}
	
	public String getName() {
		return name;
	}
	
	public String getType() {
		return type;
	}
}
