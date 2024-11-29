### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ 5c4a9909-c36a-4f8f-a473-703b3de740bf
auxiliary_words = Set([ 
	# Предлоги (одно- и двухбуквенные)
    "а", "в", "во", "до", "за", "из", "к", "ко", "на", "не", "о", "об", "от", "по", "с", "со", "у",

    # Союзы
    "и", "но", "да", "ни", "ли", "то", "же",

    # Частицы
    "бы", "же", "ли", "не", "ни", "то", "уж", "ведь", "лишь",

    # Междометия
    "ах", "ох", "эх", "ой", "ай", "эй", "ух", "э", "о", "ну", "ух", "фу",

    # Местоимения (одно- и двухбуквенные)
    "я", "мы", "ты", "он", "вы"
])



# ╔═╡ 5dde4114-a5e1-11ef-3760-6df20eeb2d0a
function generate_valid_partitions(word::String, auxiliary_words::Set{String})
    letters = collect(word)  # Преобразуем строку в массив символов
    n = length(letters)
    partitions = []

    function recurse(position::Int, current_segment::Vector{Char}, current_partition::Vector{String})
        if position > n
            # Достигли конца слова, добавляем последнее разбиение
            segment_str = join(current_segment)
            # Проверяем последний сегмент
            if is_valid_segment(segment_str, auxiliary_words)
                new_partition = copy(current_partition)
                push!(new_partition, segment_str)
                push!(partitions, join(new_partition, " "))
            end
            return
        end

        # Добавляем текущую букву к текущему сегменту
        current_segment_new = copy(current_segment)
        push!(current_segment_new, letters[position])

        # Пытаемся продолжить без вставки пробела
        recurse(position + 1, current_segment_new, current_partition)

        # Пытаемся вставить пробел, если текущий сегмент валиден
        segment_str = join(current_segment_new)
        if is_valid_segment(segment_str, auxiliary_words)
            # Сохраняем текущий сегмент и начинаем новый
            new_partition = copy(current_partition)
            push!(new_partition, segment_str)
            # Начинаем новый сегмент
            recurse(position + 1, Char[], new_partition)
        end
    end

    # Функция для проверки валидности сегмента
    function is_valid_segment(segment::String, auxiliary_words::Set{String})
        len = length(collect(segment))
        return len > 2 || (len <= 2 && (segment in auxiliary_words))
    end

    # Начинаем рекурсию с первой позиции
    recurse(1, Char[], String[])

    return partitions
end

# ╔═╡ 1a575e49-1aa5-46a6-9430-b753da019190
begin
	
	word = "механизмов"  # Замените на любое слово
	partitions = generate_valid_partitions(word, auxiliary_words)
	num_partitions = length(partitions)
	
end

# ╔═╡ 18756300-accb-4878-a98a-5872b34bddb0
begin
println("Количество разбиений: ", num_partitions)
println("Список разбиений:")
for partition in partitions
    println(partition)
end
end

# ╔═╡ Cell order:
# ╠═5c4a9909-c36a-4f8f-a473-703b3de740bf
# ╠═5dde4114-a5e1-11ef-3760-6df20eeb2d0a
# ╠═1a575e49-1aa5-46a6-9430-b753da019190
# ╠═18756300-accb-4878-a98a-5872b34bddb0
