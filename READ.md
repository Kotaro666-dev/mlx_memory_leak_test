# The puroose

The purpose of this repository is to get to know how to deal with the memory allcation created by minilibx library.
<br>
<br>

# TOOL to detect memroy leak

Valgrind
<br>
<br>

# Environment

Virtual Machine and Linux, which are recommended tools by 42 Network
<br>

# How to use

1. make
2. make valgrind
<br>

# main.c

```
typedef struct	s_game
{
	void			*mlx;
}				t_game;

int main(int argc, char **argv)
{
	t_game game;
	game.mlx = mlx_init();
	mlx_destroy_display(game.mlx);
	free(game.mlx);
	game.mlx = NULL;
	return (0);
}
```
<br>

# Issue

Minilibx library for linux has a function called "mlx_destroy_display()".
This function is supposed to free mlx_ptr, which is allocated by the function "mlx_init()".
<br>
<br>
It seems that "mlx_destroy_display()" can free still-reachable memory, but brings the other memory leak "definetly lost"
<br>
<br>

## 1st Example with mlx_destroy_window()
<br>

```
typedef struct	s_game
{
	void			*mlx;
}				t_game;

int main(int argc, char **argv)
{
	t_game game;
	game.mlx = mlx_init();
	mlx_destroy_display(game.mlx);
	return (0);
}
```
<br>

**Valgrind detected definitely lost**

<br>

```
==4665== HEAP SUMMARY:
==4665==     in use at exit: 120 bytes in 1 blocks
==4665==   total heap usage: 87 allocs, 86 frees, 75,181 bytes allocated
==4665==
==4665== 120 bytes in 1 blocks are definitely lost in loss record 1 of 1
==4665==    at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4665==    by 0x108CEA: mlx_init (in /home/user42/shared_VM/test/test)
==4665==    by 0x108B92: main (in /home/user42/shared_VM/test/test)
==4665==
==4665== LEAK SUMMARY:
==4665==    definitely lost: 120 bytes in 1 blocks
==4665==    indirectly lost: 0 bytes in 0 blocks
==4665==      possibly lost: 0 bytes in 0 blocks
==4665==    still reachable: 0 bytes in 0 blocks
==4665==         suppressed: 0 bytes in 0 blocks
```
<br>


### What does definitely lost mean?
>heap-allocated memory that was never freed to which the program no longer has a pointer. Valgrind knows that you once had the pointer, but have since lost track of it.

<br>

## 2nd Example with free()
<br>

```
typedef struct	s_game
{
	void			*mlx;
}				t_game;

int main(int argc, char **argv)
{
	t_game game;
	game.mlx = mlx_init();
	free(game.mlx);
	game.mlx = NULL;
	return (0);
}
```
<br>

**Valgrind detects still reachable**
```
==4924== HEAP SUMMARY:
==4924==     in use at exit: 67,820 bytes in 37 blocks
==4924==   total heap usage: 84 allocs, 47 frees, 75,109 bytes allocated
==4924==
==4924== LEAK SUMMARY:
==4924==    definitely lost: 0 bytes in 0 blocks
==4924==    indirectly lost: 0 bytes in 0 blocks
==4924==      possibly lost: 0 bytes in 0 blocks
==4924==    still reachable: 67,820 bytes in 37 blocks
==4924==         suppressed: 0 bytes in 0 blocks
==4924== Reachable blocks (those to which a pointer was found) are not shown.
```
<br>

### What does stll reachable mean?
>heap-allocated memory that was never freed to which the program still has a pointer at exit.

<br>

## 3rd example with mlx_destroy_window() and free()
<br>

```
typedef struct	s_game
{
	void			*mlx;
}				t_game;

int main(int argc, char **argv)
{
	t_game game;
	game.mlx = mlx_init();
	mlx_destroy_display(game.mlx);
	free(game.mlx);
	game.mlx = NULL;
	return (0);
}
```
<br>
<br>

**Valgrind detects no leaks**

```
==5106== HEAP SUMMARY:
==5106==     in use at exit: 0 bytes in 0 blocks
==5106==   total heap usage: 87 allocs, 87 frees, 75,181 bytes allocated
==5106==
==5106== All heap blocks were freed -- no leaks are possible
```
<br>
<br>


## Conclusion
<br>

The best practice to achieve no momory leak might be the combination of mlx_destroy_window() and free().
