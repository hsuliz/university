import bpy
import math
import random

context = bpy.context
target_color = [0.0, 0.0, 0.0]


def create_colored_cube(size, location, color):
    verts = (
        (-size / 2, -size / 2, -size / 2),
        (size / 2, -size / 2, -size / 2),
        (-size / 2, size / 2, -size / 2),
        (size / 2, size / 2, -size / 2),
        (-size / 2, -size / 2, size / 2),
        (size / 2, -size / 2, size / 2),
        (-size / 2, size / 2, size / 2),
        (size / 2, size / 2, size / 2)
    )

    faces = (
        (0, 1, 3, 2),
        (4, 5, 7, 6),
        (0, 1, 5, 4),
        (2, 3, 7, 6),
        (0, 2, 6, 4),
        (1, 3, 7, 5)
    )

    mesh = bpy.data.meshes.new("ColoredCube")
    mesh.from_pydata(verts, [], faces)

    cube_object = bpy.data.objects.new("ColoredCube", mesh)
    context.collection.objects.link(cube_object)

    cube_object.location = location

    context.view_layer.objects.active = cube_object

    color_material = bpy.data.materials.new("ColorMaterial")
    color_material.use_nodes = False
    color_material.diffuse_color = (*color, 1.0)
    cube_object.data.materials.append(color_material)


def dragon_curve(axiom, iterations):
    rules = {'X': 'X+YF+', 'Y': '-FX-Y'}
    result = axiom

    for _ in range(iterations):
        result = ''.join(rules.get(c, c) for c in result)

    return result


def evaluate_color(color):
    distance = math.sqrt(sum((c - target_c) ** 2 for c, target_c in zip(color, target_color)))
    fitness = 1 / (1 + distance)
    return fitness


def mutate(color, mutation_scale=80):
    return [c + random.uniform(-mutation_scale, mutation_scale) for c in color]


def distinct_crossover(parent1, parent2, bias=0.7):
    return [p1 if random.random() < bias else p2 for p1, p2 in zip(parent1, parent2)]


population_size = 350
num_generations = 80

population = [[1.0, 1.0, 1.0]] + [[random.random(), random.random(), random.random()] for _ in
                                  range(population_size - 1)]

cube_colors = []

prev_color = population[0]

for generation in range(num_generations):
    fitness_scores = [evaluate_color(color) for color in population]

    # Selekcja
    parents = [population[i] for i in sorted(range(len(population)), key=lambda k: fitness_scores[k], reverse=True)[:2]]

    # Recombinacja
    offspring = [distinct_crossover(parents[0], parents[1]) for _ in range(population_size - 2)]
    # Mutacja
    offspring = [mutate(color) for color in offspring]

    population = parents + offspring

    best_color = population[0]
    cube_colors.append(best_color)
    prev_color = best_color


def get_next_color(prev_color, variation_scale=0.1):
    return [max(0, min(1, c + random.uniform(-variation_scale, variation_scale))) for c in prev_color]


cube_size = 2.0
dragon_iterations = 10
dragon_string = dragon_curve('FX', dragon_iterations)

x, y, z = 0.0, 0.0, 0.0
num_cubes = len(dragon_string)

for i, char in enumerate(dragon_string):
    create_colored_cube(cube_size, (x, y, z), prev_color)

    prev_color = get_next_color(prev_color)

    if char == 'F':
        x += cube_size
    elif char == '-':
        angle = math.radians(-90)
        x, y = x * math.cos(angle) - y * math.sin(angle), x * math.sin(angle) + y * math.cos(angle)
    elif char == '+':
        angle = math.radians(90)
        x, y = x * math.cos(angle) - y * math.sin(angle), x
