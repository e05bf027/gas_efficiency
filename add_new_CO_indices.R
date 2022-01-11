# add_new_CO_indices.R
# ========================================================================
# adds new indices of CV function based on the derivations resting on the
# Liljestrand and Zander method for estimation of CO from arterial BP.
#   - CO (Koenig 2015 paper)
#   - DO2 (uses CaO2 as per add_new_gas_indices.R)
#   - SVR (uses above CO measure)
#   - CVP (using SVR = (MAP - CVP)/CO * 80)
#
# ========================================================================

# tidy_co <- tidy_tibble %>% mutate(
#   cardiac_output_lz = ((arterial_pressure_systolic - arterial_pressure_diastolic) / 
#                       (arterial_pressure_systolic + arterial_pressure_diastolic)) *
#                       heart_rate
# )

The problem with the above is that it leads to CO values vastly more than normal
e.g. 40L/min. There is a correction factor, k, applied. Details of this are found
in Sun (2005). The confounder here is that most patients have pressors running 
as infusions (most commonly noradrenaline) AND that the reason for their presence
in ICU can impair cardiac function (never mind PMHx).