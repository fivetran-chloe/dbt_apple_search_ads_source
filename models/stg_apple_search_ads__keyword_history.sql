
with base as (

    select * 
    from {{ ref('stg_apple_search_ads__keyword_history_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_apple_search_ads__keyword_history_tmp')),
                staging_columns=get_keyword_history_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        row_number() over (partition by id order by modification_time desc) = 1 as is_most_recent_record,
        id as keyword_id,
        campaign_id,
        ad_group_id,
        bid_amount,
        bid_currency,
        match_type,
        status,
        text as keywords_text
    from fields
    where deleted is false 
)

select * from final
