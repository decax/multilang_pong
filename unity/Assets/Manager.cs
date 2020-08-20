using UnityEngine;
using UnityEngine.UI;

public class Manager : MonoBehaviour
{
	[SerializeField]
	Text scorePlayer1 = default;

	[SerializeField]
	Text scorePlayer2 = default;

	[SerializeField]
	BallMove ball = default;

	int[] scores = new int[2];

	private void Awake()
	{
		ball.OnScore += OnScore;
	}

	void Reset()
	{
		scores[0] = 0;
		scores[1] = 0;

		UpdateScoreLabels();
	}

	void ResetBall()
	{
		ball.Reset();
	}

	public void OnScore(int player)
	{
		scores[player]++;

		UpdateScoreLabels();

		ResetBall();
	}

	void UpdateScoreLabels()
	{
		scorePlayer1.text = $"{scores[0]}";
		scorePlayer2.text = $"{scores[1]}";
	}
}
