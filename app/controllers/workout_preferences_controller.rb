# app/controllers/workout_preferences_controller.rb

class WorkoutPreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :find_workout_preference, only: [:edit, :update, :destroy]

  def new
    @workout_preference = WorkoutPreference.new
  end

  def show
    # Find the workout preference for the current user
    @workout_preference = WorkoutPreference.find_by(user_id: current_user.id)
      prompt = generate_prompt(@workout_preference)
      @workout_plan = generate_workout_plan(prompt)
   end

   def create
    @workout_preference = WorkoutPreference.new(workout_preference_params)
    @workout_preference.user = current_user

    # Include all preference details in the prompt when the preference is created
    prompt = generate_prompt(@workout_preference)

    # Call the method to generate the workout plan based on the prompt
    @workout_plan_generate = generate_workout_plan(prompt)

    # Set the workout_plan attribute
    @workout_preference.workout_plan = @workout_plan_generate

    if @workout_preference.save
      flash[:notice] = "Workout preferences saved successfully!"
      redirect_to user_workout_preference_path(current_user, @workout_preference)
    else
      # Handle validation errors or other save failures here
      flash.now[:error] = "Error: Unable to save workout preferences."
      render :new
    end
  end



  # ... Other actions ...

  private

  def generate_prompt(workout_preference)
    prompt = "Fitness Goal: #{workout_preference.fitness_goal}\n"
    prompt += "Days per Week: #{workout_preference.days_per_week}\n"
    prompt += "Time per Session: #{workout_preference.time_per_session} minutes\n"
    prompt += "Fitness Level: #{workout_preference.fitness_level}\n"
    prompt += "Additional Comments: #{workout_preference.additional_comments}\n\n"

    prompt += "Our expert trainers have carefully designed this plan to help you achieve your fitness goals. Get ready to transform yourself and make every workout count!\n\n"
    prompt += "Let's get started!\n"

    prompt
  end

  def generate_workout_plan(prompt)
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Choose the appropriate model
        messages: [
          { role: "user", content: prompt }
        ],
        temperature: 0.7 # Adjust the temperature as needed
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  def workout_preference_params
    params.require(:workout_preference).permit(:fitness_goal, :days_per_week, :time_per_session, :fitness_level, :additional_comments)
  end

  def find_user
    @user = current_user
  end

  def find_workout_preference
    @workout_preference = @user.workout_preferences.find(params[:id])
  end
end
