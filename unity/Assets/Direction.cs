enum HorizontalDirection { Left, Right };
enum VerticalDirection { Up, Down };

static class DirectionExtension
{
	public static HorizontalDirection Opposite(this HorizontalDirection direction)
	{
		switch (direction)
		{
			case HorizontalDirection.Left: return HorizontalDirection.Right;
			default:                       return HorizontalDirection.Left;
		}
	}

	public static VerticalDirection Opposite(this VerticalDirection direction)
	{
		switch (direction)
		{
			case VerticalDirection.Up: return VerticalDirection.Down;
			default:                   return VerticalDirection.Up;
		}
	}
}