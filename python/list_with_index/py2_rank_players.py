#! /usr/bin/env python
#
import unittest


def add_rank(i, player_info):
    player_info['rank'] = '#' + str(i + 1).zfill(3)
    return player_info


def rank_players_with_auto_tuple_unpack(player_list):
    return map(lambda (i, player_info): add_rank(i, player_info), enumerate(player_list))


def rank_players_with_explicit_tuple_unpack(player_list):
    return map(lambda player_info: add_rank(player_info[0], player_info[1]), enumerate(player_list))


def rank_players_with_list_comprehension(player_list):
    return [add_rank(i, player_info) for i, player_info in enumerate(player_list)]


class MapTests(unittest.TestCase):

    def get_player_list(self):
        return [
            { 'name': 'Miyako' },
            { 'name': 'Midori' }
        ]

    def get_expected_ranking(self):
        return [
            { 'rank': '#001', 'name': 'Miyako' },
            { 'rank': '#002', 'name': 'Midori' }
        ]

    def test_rank_players_with_auto_tuple_unpack(self):
        player_list = self.get_player_list()
        result = rank_players_with_auto_tuple_unpack(player_list)
        self.assertEqual(result, self.get_expected_ranking())

    def test_rank_players_with_explicit_tuple_unpack(self):
        player_list = self.get_player_list()
        result = rank_players_with_explicit_tuple_unpack(player_list)
        self.assertEqual(result, self.get_expected_ranking())

    def test_rank_players_with_list_comprehension(self):
        player_list = self.get_player_list()
        result = rank_players_with_list_comprehension(player_list)
        self.assertEqual(result, self.get_expected_ranking())


if __name__ == '__main__':
    unittest.main()
