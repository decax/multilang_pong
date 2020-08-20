using UnityEngine;

public class PaddleMove : MonoBehaviour
{
	[SerializeField]
	float speed = 10.0f;

	[SerializeField]
	KeyCode keyUp = KeyCode.Q;

	[SerializeField]
	KeyCode keyDown = KeyCode.A;

	void Update()
	{
		var position = transform.position;

		if (Input.GetKey(keyUp))
		{
			position.y += speed * Time.deltaTime;
		}
		else if (Input.GetKey(keyDown))
		{
			position.y -= speed * Time.deltaTime;
		}

		transform.position = position;
	}
}
