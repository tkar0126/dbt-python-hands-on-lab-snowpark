with lap_times as (
    select * from {{ ref('fct_lap_times') }}
    ),
    races as (
    select * from {{ ref('dim_races') }}
    ),
    expanded_lap_times_by_year as (
        select 
            lap_times.race_id, 
            driver_id, 
            race_year,
            lap,
            lap_time_milliseconds 
        from lap_times
        left join races
            on lap_times.race_id = races.race_id
        where lap_time_milliseconds is not null 
        and race_year >= 1996
    )
    select * from expanded_lap_times_by_year