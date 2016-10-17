class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.chomp.gsub(" ", "")

    words = @text.downcase.split
    @word_count = words.count

    @occurrences = words.count(@special_word.downcase)
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    monthly_interests = @apr/12/100
    number_of_payments = @years * 12
    step1= 1- ((1+monthly_interests)** (-1 * number_of_payments))
    @monthly_payment = @principal * monthly_interests / step1

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/60/60
    @days = (@ending - @starting)/60/60/24
    @weeks = (@ending - @starting)/60/60/24/7
    @years = (@ending - @starting)/60/60/24/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the  @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min


    def median(list_of_numbers)
      list_of_numbers = list_of_numbers.sort
      @count=list_of_numbers.count
      if @count.even?
        middle = (list_of_numbers.sort[(@count-1)/2] + list_of_numbers.sort[(@count+ 1)/2])/2
      else
        middle = list_of_numbers.sort[@count/2]
      end
    end

    @median = median(@numbers)

    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total
    end

    @sum = sum(@numbers)

    def mean(list_of_numbers)
      sum(list_of_numbers)
      average = sum(list_of_numbers)/list_of_numbers.count
      return average
    end

    @mean = mean(@numbers)

    def variance(list_of_numbers)
      the_mean = mean(list_of_numbers).to_f
      new_list = []
      list_of_numbers.each do |number|
        squared_differences = (the_mean - number) ** 2.to_f
        new_list.push squared_differences.to_f
      end
      variance = mean(new_list)
      return variance
    end

    @variance = variance(@numbers)

    def standard_deviation(list_of_numbers)
      @std_dev = variance(list_of_numbers)** 0.5
      return @std_dev
    end

    @standard_deviation = standard_deviation(@numbers)

    def mode(list_of_numbers)
      @frequency_array=[]
      list_of_numbers.each do |count_mode|
        @frequency_array.push list_of_numbers.count(count_mode)
      end
      @highest_freq=@frequency_array.max
      @position = @frequency_array.index(@highest_freq)
      @highest_frequency_number=list_of_numbers[@position]
      return @highest_frequency_number
    end
    @mode = mode(@numbers)



    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
