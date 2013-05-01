
public class Net {
	private Pin a;
	private Pin b;
	
	Net(Pin a, Pin b)
	{
		this.a = a;
		this.b = b;
	}
	
	public int cost()
	{
		return (Math.abs(a.x-b.x) + Math.abs(a.y-b.y));
	}
	
	public Pin getPinA()
	{
		return a;
	}
	
	public Pin getPinB()
	{
		return b;
	}
}
