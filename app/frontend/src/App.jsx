import { useState, useEffect } from "react";
import axios from "axios";

const API = "/api"; // ← FIXED

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");

  const fetchTasks = async () => {
    const res = await axios.get(`${API}/tasks`);
    setTasks(res.data);
  };

  useEffect(() => {
    fetchTasks();
  }, []);

  const addTask = async () => {
    if (!title) return;
    await axios.post(`${API}/tasks`, { title });
    setTitle("");
    fetchTasks();
  };

  const deleteTask = async (id) => {
    await axios.delete(`${API}/tasks/${id}`);
    fetchTasks();
  };

  return (
    <div style={{ padding: 30 }}>
      <h1>Task Manager</h1>

      <input
        placeholder="New Task"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
      />

      <button onClick={addTask}>Add</button>

      <ul>
        {tasks.map((t) => (
          <li key={t._id}>
            {t.title}
            <button onClick={() => deleteTask(t._id)}>X</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
