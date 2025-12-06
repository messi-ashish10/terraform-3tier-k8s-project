const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

// Health check route (for Kubernetes)
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// MongoDB connection
mongoose
  .connect(process.env.MONGO_URL || "mongodb://mongo-service:27017/tasksdb")
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.log(err));

// Model
const TaskSchema = new mongoose.Schema({
  title: String,
});

const Task = mongoose.model("Task", TaskSchema);

// API Routes (UPDATED with /api prefix)
app.get("/api/tasks", async (req, res) => {
  const tasks = await Task.find();
  res.json(tasks);
});

app.post("/api/tasks", async (req, res) => {
  const task = new Task({ title: req.body.title });
  await task.save();
  res.json(task);
});

app.delete("/api/tasks/:id", async (req, res) => {
  await Task.findByIdAndDelete(req.params.id);
  res.json({ message: "Task deleted" });
});

// Start server
app.listen(5000, () => console.log("Backend running on port 5000"));
