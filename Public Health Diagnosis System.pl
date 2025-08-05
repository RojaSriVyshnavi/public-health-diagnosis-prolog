/* Public Health diagnosis System in Prolog */

:- dynamic has_symptom/1.
:- dynamic has_risk_factor/1.

% Symptoms and risk factors database
symptom(fever).
symptom(cough).
symptom(shortness_of_breath).
symptom(fatigue).
symptom(headache).
symptom(rash).
symptom(nausea).
symptom(loss_of_taste_or_smell).
symptom(sore_throat).
symptom(muscle_ache).
symptom(diarrhea).

risk_factor(recent_travel).
risk_factor(contact_with_infected).
risk_factor(chronic_illness).
risk_factor(unvaccinated).
risk_factor(poor_hygiene).
risk_factor(immune_suppressed).

% Disease rules
illness(covid_19) :- 
    has_symptom(fever), 
    has_symptom(cough), 
    has_symptom(shortness_of_breath),
    has_symptom(loss_of_taste_or_smell),
    has_risk_factor(recent_travel).

illness(flu) :- 
    has_symptom(fever),
    has_symptom(fatigue),
    has_symptom(headache),
    has_symptom(cough),
    has_symptom(muscle_ache).

illness(food_poisoning) :- 
    has_symptom(nausea), 
    has_symptom(fatigue),
    has_symptom(headache),
    has_symptom(diarrhea).

illness(measles) :- 
    has_symptom(fever), 
    has_symptom(rash), 
    has_risk_factor(unvaccinated).

illness(strep_throat) :- 
    has_symptom(fever), 
    has_symptom(sore_throat),
    has_symptom(headache),
    has_risk_factor(contact_with_infected).

illness(dengue) :- 
    has_symptom(fever),
    has_symptom(headache),
    has_symptom(muscle_ache),
    has_risk_factor(recent_travel).

% Recommendations based on diagnosis
treatment(covid_19, "Self-isolate, get tested, and consult a doctor via telehealth.").
treatment(flu, "Rest, stay hydrated, and consider antiviral medication if severe.").
treatment(food_poisoning, "Drink fluids, rest, and seek medical attention if symptoms persist.").
treatment(measles, "Get vaccinated if not already, and see a doctor for symptom management.").
treatment(strep_throat, "Consult a doctor, take prescribed antibiotics, and rest.").
treatment(dengue, "Stay hydrated, rest, and seek medical help if symptoms worsen.").

% User interaction
ask_symptoms :-
    write("Do you have any of the following symptoms? (yes/no)"), nl,
    forall(symptom(X), (write(X), write("? "), read(Reply), (Reply == yes -> assertz(has_symptom(X)); true))),
    nl.

ask_risk_factors :-
    write("Have you been exposed to any risk factors? (yes/no)"), nl,
    forall(risk_factor(X), (write(X), write("? "), read(Reply), (Reply == yes -> assertz(has_risk_factor(X)); true))),
    nl.

run_diagnosis :-
    write("Welcome to the Public Health diagnosis System!"), nl,
    ask_symptoms,
    ask_risk_factors,
    (illness(Disease) -> treatment(Disease, Advice), write("You may have: "), write(Disease), nl, write("Advice: "), write(Advice), nl;
    write("No known disease detected. Please consult a doctor if symptoms persist."), nl),
    retractall(has_symptom(_)),
    retractall(has_risk_factor(_)).
