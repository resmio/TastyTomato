import requests
import argparse
import os


def upload(project_id, filepath):
    api_token = os.environ['POEDITOR_API_TOKEN']

    with open(filepath, 'rb') as f:
        data = {
            'id': project_id,
            'api_token': api_token,
            'updating': 'terms_translations',
            'language': 'en',
            'overwrite': 1,
        }
        files = {'file': f}
        request = requests.post('https://api.poeditor.com/v2/projects/upload', data=data, files=files)

    resp = request.json()
    print(resp)
    status = None
    try:
        status = resp['response']['status']
    except KeyError:
        print(f'Key ["response"]["status"] could not be found in {resp.content.decode()}')
        exit(1)
    if status != 'success':
        print(f'Request status not success in {resp.content.decode()}')
        exit(1)


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--project_id')
    parser.add_argument('--filepath')
    args = parser.parse_args()

    upload(project_id=args.project_id, filepath=args.filepath)
