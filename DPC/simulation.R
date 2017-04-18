library(simmer)
# Setup simulation environment
env <- simmer("Care House")
env

# Create trajectory
patient <- trajectory("patients' path") %>%
  ## add an intake activity 
  seize("nurse", 1) %>%
  timeout(function() rnorm(1, 10, 5)) %>%
  release("nurse", 1) %>%
  ## add a consultation activity
  seize("doctor", 1) %>%
  timeout(function() rnorm(1, 15, 10)) %>%
  release("doctor", 1) %>%
  ## add a planning activity
  seize("administration", 1) %>%
  timeout(function() rnorm(1, 5)) %>%
  release("administration", 1)

# Add resources
env %>%
  add_resource("nurse", 1, queue_size=5) %>%
  add_resource("doctor", 2, queue_size=0) %>%
  add_resource("administration", 1) %>%
  add_generator("patient", patient, function() rpois(2, 10))

# Run simulation
env %>% 
  run(until=9*60) %>%
  now()

# See results
arrivalsDF <- get_mon_arrivals(env)
attributesDF <- get_mon_attributes(env)
resourcesDF <- get_mon_resources(env)

library(simmer.plot)
plot(env, what = "resources", metric = "utilization", c("nurse", "doctor","administration"))
get_palette <- scales::brewer_pal(type = "qual", palette = 1)
plot(patient, fill = get_palette)

# Reset
env %>% 
  reset()
