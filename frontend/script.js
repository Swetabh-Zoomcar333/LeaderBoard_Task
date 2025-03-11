const API_BASE_URL = "http://localhost:3000/api/leaderboard";

async function fetchLeaderboard() {
  try {
    console.log("Refreshing");
    const response = await fetch(`${API_BASE_URL}/top`);
    const data = await response.json();
    data.sort((a,b)=> a.rank - b.rank)
    const tbody = document.querySelector("#leaderboard tbody");
    tbody.innerHTML = "";
    data.forEach((player, index) => {
      const row = `<tr>
                                    <td>${player.rank}</td>
                                    <td>${player.user_id}</td>
                                    <td>${player.total_score}</td>
                                </tr>`;
      tbody.innerHTML += row;
    });
  } catch (error) {
    console.error("Error fetching leaderboard:", error);
  }
}

async function fetchUserRank() {
  const userId = document.getElementById("user-id").value;
  if (!userId) return;
  try {
    const response = await fetch(`${API_BASE_URL}/rank/${userId}`);
    const data = await response.json();
    document.getElementById("rank-result").innerText = `Rank: ${data.rank}`;
  } catch (error) {
    console.error("Error fetching user rank:", error);
  }
}
document.addEventListener("DOMContentLoaded", () => {
  fetchLeaderboard();
  setInterval(fetchLeaderboard, 10000);
});
