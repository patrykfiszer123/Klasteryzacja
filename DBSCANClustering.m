close all; clear; clc;
%% Załadowanie danych
% 
data = load("dataCircle.mat").dataCircle;  % dataCircle, dataEllipse, dataParabolic, dataSpiral

%% Parametry
% 
epsilon = 2;    % Maksymalna odległość do sąsiedniego punktu
minPts = 2;     % Minimalna liczba punktów w klastrze

%% Klasteryzacja
% 
[idx, corepts] = dbscan(data, epsilon, minPts);

%% Wizualizacja
% 
colors = lines(max(idx));  % Generowanie kolorów dla kolejnych klastrów

figure(1);
hold on
% Rysowanie punktów dla każdego klastra
for i = 1:max(idx)
    % Przynależność punktów do i-tego klastra
    clusterPoints = data(idx == i, :);
    % Rysowanie punktów w kolejnym klastrze
    plot(clusterPoints(:, 1), clusterPoints(:, 2), '*', 'Color', colors(i, :), 'DisplayName', ['Klaster ' num2str(i)], 'LineWidth', 1.1, 'MarkerSize', 7);
end
%Rysowanie punktów, które są szumem
noisePoints = data(idx == -1, :);
plot(noisePoints(:, 1), noisePoints(:, 2), 'k*', 'LineWidth', 1.1, 'MarkerSize', 7, 'DisplayName', 'Szum');
% Ustawienia wykresu
hold off
grid on; grid minor;    % Siatka
xlim([min(data(:, 1)), max(data(:, 1))])    % Granice osi x
ylim([min(data(:, 2)), max(data(:, 2))])    % Granice osi y
legend show;    % Pokazanie legendy
title('DBSCAN');    % Tytuł wykresu
xlabel('x');    % Tytuł osi x
ylabel('y');    % Tytuł osi y
