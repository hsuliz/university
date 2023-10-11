program DijkstraProgram
    implicit none
    integer, parameter :: max_vertices = 100
    integer, parameter :: infinity = 999999
    integer :: num_vertices, num_edges
    character(len = 100) :: input_filename, output_filename
    integer :: adjacency_matrix(max_vertices, max_vertices)
    integer :: distance(max_vertices)
    logical :: visited(max_vertices)
    integer :: i

    write(*, *) "Enter the input filename (or 'NULL' to generate): "
    read(*, *) input_filename

    write(*, *) "Enter the output filename: "
    read(*, *) output_filename

    if (trim(adjustl(adjustl(input_filename))) == "NULL") then
        call generateGraph(num_vertices, num_edges, adjacency_matrix)
    else
        call readGraph(input_filename, num_vertices, num_edges, adjacency_matrix)
    end if

    call dijkstra(num_vertices, adjacency_matrix, distance)
    call writeDistances(output_filename, num_vertices, distance)

    write(*, *) "Shortest distances from vertex 1:"
    do i = 1, num_vertices
        write(*, '(A, I3, A, I5)') "To vertex ", i, ": ", distance(i)
    end do

contains

    subroutine readGraph(filename, num_vertices, num_edges, adjacency_matrix)
        character(len = *), intent(in) :: filename
        integer, intent(out) :: num_vertices, num_edges
        integer, intent(out) :: adjacency_matrix(:, :)
        integer :: i, j, k, vertex
        open(10, file = trim(filename), status = 'old', action = 'read')
        read(10, *) num_vertices, num_edges
        adjacency_matrix = infinity
        do i = 1, num_edges
            read(10, *) j, k, vertex
            adjacency_matrix(j, k) = vertex
        end do
        close(10)
    end subroutine readGraph

    subroutine generateGraph(num_vertices, num_edges, adjacency_matrix)
        integer, intent(out) :: num_vertices, num_edges
        integer, intent(out) :: adjacency_matrix(:, :)
        integer :: i, j, k, vertex
        write(*, *) "Enter the number of vertices: "
        read(*, *) num_vertices
        write(*, *) "Enter the number of edges: "
        read(*, *) num_edges
        write(*, *) "Enter the edges (j k vertex) for each edge:"
        adjacency_matrix = infinity
        do i = 1, num_edges
            write(*, *) "Edge ", i
            read(*, *) j, k, vertex
            adjacency_matrix(j, k) = vertex
        end do
    end subroutine generateGraph

    subroutine dijkstra(num_vertices, adjacency_matrix, distance)
        integer, intent(in) :: num_vertices
        integer, intent(in) :: adjacency_matrix(:, :)
        integer, intent(out) :: distance(:)
        logical :: visited(max_vertices)
        integer :: i, j, k, vertex, min_distance
        distance = infinity
        visited = .false.
        distance(1) = 0
        do i = 1, num_vertices
            min_distance = infinity
            vertex = -1
            do j = 1, num_vertices
                if (.not. visited(j) .and. distance(j) < min_distance) then
                    min_distance = distance(j)
                    vertex = j
                end if
            end do
            visited(vertex) = .true.
            do k = 1, num_vertices
                if (.not. visited(k) .and. adjacency_matrix(vertex, k) < infinity) then
                    distance(k) = min(distance(k), distance(vertex) + adjacency_matrix(vertex, k))
                end if
            end do
        end do
    end subroutine dijkstra

    subroutine writeDistances(filename, num_vertices, distance)
        character(len = *), intent(in) :: filename
        integer, intent(in) :: num_vertices
        integer, intent(in) :: distance(:)
        integer :: i
        open(20, file = trim(filename), status = 'replace', action = 'write')
        write(20, '(A)') "Shortest distances from vertex 1:"
        do i = 1, num_vertices
            write(20, '(A, I3, A, I5)') "To vertex ", i, ": ", distance(i)
        end do
        close(20)
    end subroutine writeDistances

end program DijkstraProgram
