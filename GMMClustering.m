close all; clear; clc;
%% Załadowanie danych
% 
data = load("dataCircle.mat").dataCircle;  % dataCircle, dataEllipse, dataParabolic, dataSpiral

%% Parametry
% 
k = 3;  % Liczba klastrów

%% Klasteryzacja
% 
% Dopasowanie modelu GMM
gmm = fitgmdist(data, k);

% Przypisanie klastrów
[idx, ~] = cluster(gmm, data);

%% Wizualizacja
% 
colors = lines(k);  % Generowanie kolorów dla kolejnych k klastrów

figure(1);
hold on
% Rysowanie punktów dla każdego klastra
for i = 1:k
    % Przynależność punktów do i-tego klastra
    clusterPoints = data(idx == i, :);
    % Rysowanie punktów w i-tym klastrze
    plot(clusterPoints(:, 1), clusterPoints(:, 2), '*', 'Color', colors(i, :), 'DisplayName', ['Klaster ' num2str(i)], 'LineWidth', 1.1, 'MarkerSize', 7);
end
% Ustawienia wykresu
hold off
grid on; grid minor;    % Siatka
xlim([min(data(:, 1)), max(data(:, 1))])    % Granice osi x
ylim([min(data(:, 2)), max(data(:, 2))])    % Granice osi y
legend show;    % Pokazanie legendy
title('Klasteryzacja GMM');  % Tytuł wykresu
xlabel('x');    % Tytuł osi x
ylabel('y');    % Tytuł osi y
