defmodule Ims.QueueHelperTest do
  use ExUnit.Case, async: false
  import Mock
  alias Ims.QueueHelper
  alias Ims.DTO.Message

  @payload %Message{}
  @job_module Ims.ReportJob

  setup_with_mocks([{TaskBunny.Job, [], [enqueue: fn(_job_module, _msg) -> :ok end]}], context) do
    context
  end

  describe "enqueue" do
    test "calls taskbunny enqueue" do
      @payload
      |> QueueHelper.enqueue(@job_module)

      assert_called(TaskBunny.Job.enqueue(@job_module, @payload))
    end
  end
end
