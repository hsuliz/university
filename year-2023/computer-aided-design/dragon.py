import bpy
import math
import colorsys

context = bpy.context

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
    color_material.diffuse_color = color
    cube_object.data.materials.append(color_material)


def dragon_curve(axiom, iterations):
    rules = {'X': 'X+YF+', 'Y': '-FX-Y'}
    result = axiom

    for _ in range(iterations):
        result = ''.join(rules.get(c, c) for c in result)

    return result


cube_size = 2.0
num_cubes = 10
dragon_iterations = 10

dragon_string = dragon_curve('FX', dragon_iterations)

x, y, z = 0.0, 0.0, 0.0
for i, char in enumerate(dragon_string):
    color = colorsys.hsv_to_rgb(i / dragon_iterations, 1.0, 1.0)
    color_with_alpha = (*color, 1.0)
    create_colored_cube(cube_size, (x, y, z), color_with_alpha)
    if char == 'F':
        x += cube_size
    elif char == '-':

        angle = math.radians(-90)
        x, y = x * math.cos(angle) - y * math.sin(angle), x * math.sin(angle) + y * math.cos(angle)
    elif char == '+':

        angle = math.radians(90)
        x, y = x * math.cos(angle) - y * math.sin(angle), x * math.sin(angle) + y * math.cos(angle)
