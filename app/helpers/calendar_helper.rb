module CalendarHelper
  # Generates a calendar for a given month
  def month_calendar(events:, date: Date.today, &block)
    start_date = date.beginning_of_month.beginning_of_week(:sunday)
    end_date   = date.end_of_month.end_of_week(:sunday)

    weeks = (start_date..end_date).to_a.in_groups_of(7)

    content_tag :table, class: "table table-bordered text-center align-middle" do
      # Table header (days of week)
      concat(content_tag(:thead) do
        content_tag(:tr) do
          Date::ABBR_DAYNAMES.map do |day|
            concat(content_tag(:th, day))
          end
        end
      end)

      # Table body (weeks + days)
      concat(content_tag(:tbody) do
        weeks.map do |week|
          content_tag(:tr) do
            week.map do |day|
              day_events = events.select { |e| e.event_start_at.to_date == day }
              concat(content_tag(:td, class: ("bg-light text-muted" if day.month != date.month)) do
                concat(content_tag(:div, day.day, class: "fw-bold small mb-1"))
                day_events.each do |event|
                  concat capture(event, &block) # yield to caller’s block for custom rendering
                end
              end)
            end.join.html_safe
          end
        end.join.html_safe
      end)
    end
  end
end
