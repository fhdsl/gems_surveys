# Package setup ---------------------------------------------------------------

# Install required packages:
# install.packages("pak")
pak::pak("surveydown-dev/surveydown@v0.13.4-gssencmode-fix", ask = FALSE)

# Load packages
library(surveydown)

# Database setup --------------------------------------------------------------
#
# Details at: https://surveydown.org/docs/storing-data
#
# surveydown stores data on any PostgreSQL database. We recommend
# https://supabase.com/ for a free and easy to use service.
#
# Once you have your database ready, run the following function to store your
# database configuration parameters in a local .env file:
#
# sd_db_config()
#
# Once your parameters are stored, you are ready to connect to your database.
# For this demo, we set ignore = TRUE in the following code, which will ignore
# the connection settings and won't attempt to connect to the database. This is
# helpful if you don't want to record testing data in the database table while
# doing local testing. Once you're ready to collect survey responses, set
# ignore = FALSE or just delete this argument.

db <- sd_db_connect(ignore = TRUE)

# UI setup --------------------------------------------------------------------

ui <- sd_ui()

# Server setup ----------------------------------------------------------------

server <- function(input, output, session) {

  # Define any conditional forward skipping logic here
  sd_skip_if(
    # Consent
    input$consent == 'no' ~ 'screenout'
  )

  observe({
    module_name <- sd_output("modulename", type = "label_option")

    #make question label
    labelrid <- glue::glue("Enter the random ID from before the **{module_name}** activity.")
    
    #default label for module question
    labelrid_default <- "Enter the random ID from before the activity."
    if (is.null(input$modulename)) labelrid <- labelrid_default
    else if (input$modulename == "")labelrid <- labelrid_default

    #make the random ID question
    sd_question(
      type = "text",
      id = "random_id",
      label = labelrid
    )

  })

  # Run surveydown server and define database
  sd_server(db = db)
}

# Launch the app
shiny::shinyApp(ui = ui, server = server)
