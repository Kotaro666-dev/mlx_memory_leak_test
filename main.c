/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kkamashi <kkamashi@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/11/23 10:21:57 by kkamashi          #+#    #+#             */
/*   Updated: 2020/11/23 10:51:24 by kkamashi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minilibx-linux/mlx.h"
#include "stdio.h"
#include "stdlib.h"

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
