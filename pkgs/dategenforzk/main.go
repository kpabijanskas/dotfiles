package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

func main() {
	os.Exit(run())
}

func run() int {
	el := flag.String("element", "", "element to get")
	debug := flag.Bool("debug", false, "")
	txt := flag.Bool("txt", false, "")
	flag.Parse()

	t, err := parse(strings.Join(flag.Args(), "-"))
	if err != nil {
		fmt.Println(err)
		return 1
	}
	d := getDate(t)

	if *debug {
		data, err := json.Marshal(&d)
		if err != nil {
			fmt.Printf("err marshaling: %v", err)
			return 1
		}

		fmt.Println(string(data))
		return 0
	}

	if *txt {
		var vars []string
		vars = append(vars, fmt.Sprintf("date=%s", d.Date))
		vars = append(vars, fmt.Sprintf("weekday=%s", d.Weekday))
		vars = append(vars, fmt.Sprintf("date_before=%s", d.DayBefore.Date))
		vars = append(vars, fmt.Sprintf("weekday_before=%s", d.DayBefore.Weekday))
		vars = append(vars, fmt.Sprintf("date_after=%s", d.DayAfter.Date))
		vars = append(vars, fmt.Sprintf("weekday_after=%s", d.DayAfter.Weekday))
		for i, wd := range d.Weekdays {
			vars = append(vars, fmt.Sprintf("week_day_%d_date=%s", i+1, wd.Date))
			vars = append(vars, fmt.Sprintf("week_day_%d_weekday=%s", i+1, wd.Weekday))
		}
		vars = append(vars, fmt.Sprintf("year_week=%s", d.YearWeek))
		vars = append(vars, fmt.Sprintf("year_week_before=%s", d.YearWeekBefore))
		vars = append(vars, fmt.Sprintf("year_week_after=%s", d.YearWeekAfter))
		for i, wim := range d.YearWeeksInMonth {
			vars = append(vars, fmt.Sprintf("year_weeks_in_month_%d=%s", i+1, wim))
		}
		vars = append(vars, fmt.Sprintf("year_month=%s", d.YearMonth))
		vars = append(vars, fmt.Sprintf("year_month_before=%s", d.YearMonthBefore))
		vars = append(vars, fmt.Sprintf("year_month_after=%s", d.YearMonthAfter))
		vars = append(vars, fmt.Sprintf("year=%s", d.Year))
		vars = append(vars, fmt.Sprintf("year_before=%s", d.YearBefore))
		vars = append(vars, fmt.Sprintf("year_after=%s", d.YearAfter))

		fmt.Print(strings.Join(vars, ","))
		return 0
	}

	if *el == "" {
		fmt.Printf("no element specified")
		return 1
	}

	switch *el {
	case "date":
		fmt.Print(d.Date)
	case "date_before":
		fmt.Print(d.DayBefore)
	case "date_after":
		fmt.Print(d.DayAfter)
	case "weekdays":
		wds := make([]string, 0, 7)
		for _, wd := range d.Weekdays {
			wds = append(wds, wd.String())
		}
		fmt.Print(strings.Join(wds, ","))
	case "year_week":
		fmt.Print(d.YearWeek)
	case "year_week_before":
		fmt.Print(d.YearWeekBefore)
	case "year_week_after":
		fmt.Print(d.YearWeekAfter)
	case "year_weeks_in_month":
		fmt.Print(strings.Join(d.YearWeeksInMonth, ","))
	case "year_month":
		fmt.Print(d.YearMonth)
	case "year_month_before":
		fmt.Print(d.YearMonthBefore)
	case "year_month_after":
		fmt.Print(d.YearMonthAfter)
	case "year":
		fmt.Print(d.Year)
	case "year_before":
		fmt.Print(d.YearBefore)
	case "year_after":
		fmt.Print(d.YearAfter)
	default:
		fmt.Printf("unknown element '%s'\n", *el)
		return 1
	}

	return 0
}

func getDate(t time.Time) Date {
	d := Date{
		Day: Day{
			Date:    t.Format(time.DateOnly),
			Weekday: t.Weekday().String(),
		},
		YearMonth:  fmt.Sprintf("%d-%02d", t.Year(), t.Month()),
		Year:       fmt.Sprintf("%d", t.Year()),
		YearAfter:  fmt.Sprintf("%d", t.Year()+1),
		YearBefore: fmt.Sprintf("%d", t.Year()-1),
	}

	tadjusted := t.AddDate(0, 0, 1)
	d.DayAfter = Day{
		Date:    tadjusted.Format(time.DateOnly),
		Weekday: tadjusted.Weekday().String(),
	}

	tadjusted = t.AddDate(0, 0, -1)
	d.DayBefore = Day{
		Date:    tadjusted.Format(time.DateOnly),
		Weekday: tadjusted.Weekday().String(),
	}

	tadjusted = t
	for tadjusted.Weekday() != time.Monday {
		tadjusted = tadjusted.AddDate(0, 0, -1)
	}

	for i := 0; i < 7; i++ {
		d.Weekdays = append(d.Weekdays, Day{
			Date:    tadjusted.Format(time.DateOnly),
			Weekday: tadjusted.Weekday().String(),
		})
		tadjusted = tadjusted.AddDate(0, 0, 1)
	}

	y, w := t.ISOWeek()
	d.YearWeek = fmt.Sprintf("%d-W%02d", y, w)

	tadjusted = t.AddDate(0, 0, -7)
	y, w = tadjusted.ISOWeek()
	d.YearWeekBefore = fmt.Sprintf("%d-W%02d", y, w)

	tadjusted = t.AddDate(0, 0, 7)
	y, w = tadjusted.ISOWeek()
	d.YearWeekAfter = fmt.Sprintf("%d-W%02d", y, w)

	firstDayOfMonth := time.Date(t.Year(), t.Month(), 1, 0, 0, 0, 0, time.Local)
	lastDayOfMonth := firstDayOfMonth.AddDate(0, 1, -1)
	_, firstWeek := firstDayOfMonth.ISOWeek()
	_, lastWeek := lastDayOfMonth.ISOWeek()
	for firstWeek > lastWeek {
		firstDayOfMonth = firstDayOfMonth.AddDate(0, 0, 1)
		_, firstWeek = firstDayOfMonth.ISOWeek()
	}
	for firstWeek <= lastWeek {
		d.YearWeeksInMonth = append(d.YearWeeksInMonth, fmt.Sprintf("%d-W%02d", t.Year(), firstWeek))
		firstWeek++
	}

	tadjusted = t.AddDate(0, -1, 0)
	d.YearMonthBefore = fmt.Sprintf("%d-%02d", tadjusted.Year(), tadjusted.Month())

	tadjusted = t.AddDate(0, 1, 0)
	d.YearMonthAfter = fmt.Sprintf("%d-%02d", tadjusted.Year(), tadjusted.Month())

	return d
}

func parse(date string) (time.Time, error) {
	if date == "" {
		return time.Now(), nil
	}
	if strings.Contains(date, "-W") {
		fields := strings.Split(date, "-W")
		t, err := time.ParseInLocation("2006", fields[0], time.Local)
		t = t.AddDate(0, 0, 4) //adjust as first few days could belong to previous year
		if err != nil {
			return time.Time{}, err
		}

		wn, err := strconv.Atoi(fields[1])
		if err != nil {
			return time.Time{}, err
		}

		_, w := t.ISOWeek()
		for w != wn {
			t = t.AddDate(0, 0, 1)
			_, w = t.ISOWeek()
		}

		return t, nil
	}
	if t, err := time.ParseInLocation("2006-01-02", date, time.Local); err == nil {
		return t, nil
	}
	if t, err := time.ParseInLocation("2006-01", date, time.Local); err == nil {
		return t, nil
	}
	if t, err := time.ParseInLocation("2006", date, time.Local); err == nil {
		return t, nil
	}
	return time.Time{}, fmt.Errorf("unable to parse %s", date)
}

type Date struct {
	Day              `json:"day"`
	DayBefore        Day      `json:"day_before"`
	DayAfter         Day      `json:"day_after"`
	Weekdays         []Day    `json:"weekdays"`
	YearWeek         string   `json:"year_week"`
	YearWeekBefore   string   `json:"year_week_before"`
	YearWeekAfter    string   `json:"year_week_after"`
	YearWeeksInMonth []string `json:"year_weeks_in_month"`
	YearMonth        string   `json:"year_month"`
	YearMonthBefore  string   `json:"year_month_before"`
	YearMonthAfter   string   `json:"year_month_after"`
	Year             string   `json:"year"`
	YearBefore       string   `json:"year_before"`
	YearAfter        string   `json:"year_after"`
}

type Day struct {
	Date    string `json:"date"`
	Weekday string `json:"weekday"`
}

func (d Day) String() string {
	return fmt.Sprintf("%s:%s", d.Date, d.Weekday)
}
