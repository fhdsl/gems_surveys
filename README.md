# gems_surveys
A collection of surveys for GEMs

## student_pre_survey

Survey is made using [surveydown](https://surveydown.org/) with a [supabase](https://supabase.com/) database connection and will be hosted as a shiny app with [rsconnect](https://docs.posit.co/shinyapps.io/guide/getting_started/). For both the supabase database and rsconnect shiny app hosting, the GEMs Fred Hutch email account is necessary for login and management.

### Survey description

This survey has 3 sections after the background information and consent.

1. Section 1: Respondents select the GEM module and instructor.
1. Section 2: A matrix question (likert scale 1 to 10) asking respondents about their skills and interest.
1. Section 3: Another matrix question (likert scale 1 to 5) asking respondents about interests and general knowledge as well as an optional text response question for further explanation.

The final page of the survey displays a 10 digit Random ID that will be used to anonymously connect pre and post survey responses.

If respondents did not consent, there is a screenout page thanking students for their interest and explaining they do not meet the eligibility requirements.

Every question is required except for the optional text response question in Section 3.

### Survey files

There are two files associated with this survey:

* `survey.qmd`: This file contains the page and question structure of the survey.
* `app.R`: This file controls
  * the shiny app
  * conditional logic/consent navigation
  * It also creates one survey question (instructor selection `id=instructor`) that has "reactivity"
    * It incorporates the response from another question into the displayed question label.
    * There is some additional conditional logic before that question that toggles the label so that the `modulename` answer isn't incorporated until the respondent selects a module.
  * The Random ID/`completion_code` creation and storing in the database.


## student_post_survey

Survey is made using [surveydown](https://surveydown.org/) with a [supabase](https://supabase.com/) database connection and will be hosted as a shiny app with [rsconnect](https://docs.posit.co/shinyapps.io/guide/getting_started/). For both the supabase database and rsconnect shiny app hosting, the GEMs Fred Hutch email account is necessary for login and management.

### Survey description

This survey has 5 sections after the background information and consent.

1. Section 1: Respondents select the GEM module, selects the date of completion, and fills in the 10 digit Random ID from the pre survey.
1. Section 2: A matrix question (likert scale 1 to 10) asking respondents about their skills and interest. This mirrors the pre survey.
1. Section 3: Another matrix question (likert scale 1 to 5) asking respondents about interests and general knowledge as well as an optional text response question for further explanation. This mirrors the pre survey.
1. Section 4: A matrix question (likert scale 1 to 5) asking respondents about the module/activity specifically as well as an optional text response question for further explanation.
1. Section 5: 3 optional text response questions about the module/activity.

The final page of the survey thanks the respondent for taking the survey.

If respondents did not consent, there is a screenout page thanking students for their interest and explaining they do not meet the eligibility requirements.

Every question is required except for the optional text response questions in Section 3, Section 4, and Section 5.

### Survey files

There are two files associated with this survey:

* `survey.qmd`: This file contains the page and question structure of the survey.
* `app.R`: This file controls
  * the shiny app
  * conditional logic/consent navigation
  * It also creates one survey question (Random ID provision `id=random_id`) that has "reactivity"
    * It incorporates the response from another question into the displayed question label.
    * There is some additional conditional logic before that question that toggles the label so that the `modulename` answer isn't incorporated until the respondent selects a module.
  * The Random ID validation ensuring that what the respondent provides is 10 digits before they can navigate to the next page.
