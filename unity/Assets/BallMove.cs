using System;
using UnityEngine;

public class BallMove : MonoBehaviour
{
	public event Action<int> OnScore;

	[SerializeField]
	float speed = 10;

	HorizontalDirection horizontalDirection = HorizontalDirection.Left;
	VerticalDirection verticalDirection = VerticalDirection.Up;

	public void Reset()
	{
		transform.position = Vector3.zero;
		horizontalDirection = UnityEngine.Random.Range(0, 1) == 0 ? HorizontalDirection.Left : HorizontalDirection.Right;
		verticalDirection = UnityEngine.Random.Range(0, 1) == 0 ? VerticalDirection.Up : VerticalDirection.Down;
	}

	void Update()
	{
		var position = transform.position;
		var deltaSpeed = speed * Time.deltaTime;

		position.x += deltaSpeed * (horizontalDirection == HorizontalDirection.Left ? -1 : 1);
		position.y += deltaSpeed * (verticalDirection == VerticalDirection.Down ? -1 : 1);

		transform.position = position;
	}

	void OnTriggerEnter2D(Collider2D other)
	{
		switch (other.name)
		{
			case "Paddle 1":
			case "Paddle 2":
				horizontalDirection = horizontalDirection.Opposite();
				break;

			case "Bound Up":
			case "Bound Down":
				verticalDirection = verticalDirection.Opposite();
				break;

			case "Goal 1":
				OnScore(1);
				break;

			case "Goal 2":
				OnScore(0);
				break;
		}
	}
}
