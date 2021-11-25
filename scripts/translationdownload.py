import argparse
import requests
import time
from pathlib import Path
import os

OUTPUT_TYPES = [
    'po',
]

start_time = time.time()

langs = [
    {
        'remote': 'cs',
        'folder': 'cs'
    },
    {
        'remote': 'da',
        'folder': 'da'
    },
    {
        'remote': 'nl',
        'folder': 'nl'
    },
    {
        'remote': 'en',
        'folder': 'en'
    },
    {
        'remote': 'fr',
        'folder': 'fr'
    },
    {
        'remote': 'de',
        'folder': 'de'
    },
    {
        'remote': 'it',
        'folder': 'it'
    },
    {
        'remote': 'pl',
        'folder': 'pl'
    },
    {
        'remote': 'pt',
        'folder': 'pt'
    },
    {
        'remote': 'es',
        'folder': 'es'
    },
    {
        'remote': 'sv',
        'folder': 'sv'
    },
    {
        'remote': 'tr',
        'folder': 'tr'
    },
]


def main(project_id, file_filter):
    """Entry point"""
    api_token = os.environ['POEDITOR_API_TOKEN']

    for lang in langs:
        url = f'https://api.poeditor.com/v2/projects/export'
        file_name = file_filter.replace('<lang>', lang['folder'])
        (output_dir, _) = os.path.split(file_name)

        Path(output_dir).mkdir(parents=True, exist_ok=True)
        for output_type in OUTPUT_TYPES:
            data = {
                'api_token': api_token,
                'id': project_id,
                'language': lang['remote'],
                'type': output_type,
            }

            resp = requests.post(url, data=data)
            result = resp.json()
            print(result)
            try:
                url = result['result']['url']
            except KeyError:
                print(
                    f'Key ["result"]["url"] could not be found in {resp.content.decode()} for language {lang["remote"]}'
                )
                exit(1)

            result = requests.get(url)
            with open(file_name, 'wb') as f:
                f.write(result.content)

            # time.sleep(5)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--project_id')
    parser.add_argument('--file_filter')
    args = parser.parse_args()

    main(args.project_id, args.file_filter)
