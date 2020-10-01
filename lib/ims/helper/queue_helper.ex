defmodule Ims.QueueHelper do
  alias Ims.DTO.Message

  def enqueue(%Message{} = msg, job_module) do
    TaskBunny.Job.enqueue(job_module, msg)
  end
end
