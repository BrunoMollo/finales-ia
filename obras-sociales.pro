% persona(dni,nombre,edad,obraSocial,plan).
% obraSocial (obra,plan, medicamento,%cobertura).
%
% 1- devolver una lista con los DNI de las personas que tengan más de 65 años
% y cuyo plan cubra al menos 10 medicamentos al 100%.
% 2- devolver los datos de aquellas personas que tengan más de una obra social.

:- dynamic(persona/5).
:- dynamic(obraSocial/4).
:- dynamic(auxOS/4).
