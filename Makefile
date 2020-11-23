# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kkamashi <kkamashi@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/23 10:22:00 by kkamashi          #+#    #+#              #
#    Updated: 2020/11/23 10:27:08 by kkamashi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = test
MLX = minilibx-linux
LIBMLX = libmlx.a
LIBMLX_PATH = $(MLX)/$(LIBMLX)
OPTIONS = -lXext -lX11

all:
	$(MAKE) -C ./$(MLX)
	cp $(LIBMLX_PATH) ./
	gcc main.c ${LIBMLX} ${OPTIONS} -o ${NAME}

clean:
	$(RM) main.o

fclean:
	$(MAKE) clean -C ./$(MLX)
	$(RM) $(NAME) $(LIBMLX)

re: fclean all

valgrind:
	valgrind --leak-check=full ./${NAME}

.PHONY: all clean fclean re
