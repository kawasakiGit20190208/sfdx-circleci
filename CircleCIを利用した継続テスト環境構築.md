# Salesforce CLI�𗘗p����CircleCI�o�R�Ŏ������e�X�g���s�����\�z�菇
�Q�l�T�C�g  
https://trailhead.salesforce.com/ja/content/learn/modules/sfdx_travis_ci/sfdx_travis_ci_connected_app

## Openssl�ɂ�鎩�ȏ���SSL�ؖ�������є���J���̍쐬

server.key�t�@�C�������[�J���ňÍ������邽�߂̌��Ə������x�N�g���iiv�j�𐶐����܂��B 
����iv��Circleci���r���h����server.key�𕜍�������̂Ɏg���܂��B  

windows�ł�openssl�͂����炩��_�E�����[�h�ł��܂��B  
(http://gnuwin32.sourceforge.net/packages/openssl.htm)  
**Complete package, except sources** ���C���X�g�[�����܂����B  

�C���X�g�[����A[�V�X�e���̏ڍאݒ�] -> [���ϐ�] -> [Path] -> [�ҏW]�ɂ�openssl.exe�̂���f�B���N�g����ǉ����Ă��������B  
�L�[���쐬���钆�ŁAopenssl.cnf���K�v�ƂȂ�܂��B  
���������ϐ���ǉ����邩�A�R�}���h�v�����v�g���openssl.cnf�ւ�Path��ʂ��Ă����Ă��������B  
   [��] set OPENSSL_CONF=C:\Program Files (x86)\GnuWin32\share\openssl.cnf

1. Git���|�W�g���f�B���N�g���̊O���ɓK���ȃf�B���N�g�����쐬���Ă��������B  
(mkdir certificates)

2. �쐬�����f�B���N�g���Ɉړ����܂��B  
  cd certificates

3. RSA����J�����쐬���܂��B  
  openssl genrsa -des3 -passout pass:x -out server.pass.key 2048

4. server.pass.key�t�@�C�����献�t�@�C�����쐬���܂��B  
  openssl rsa -passin pass:x -in server.pass.key -out server.key

5. server.pass.key ���폜���܂��B(rm server.pass.key)

6. �ؖ�����v�����Đ������܂��B  
  openssl req -new -key server.key -out server.csr  
  ����͈ȉ��̓��e�Őݒ肵�Ă���܂��B 

```bash
Country Name (2 letter code) [AU]:JP
State or Province Name (full name) [Some-State]:Tokyo
Locality Name (eg, city) []:Chuoku
Organization Name (eg, company) [Internet Widgits Pty Ltd]:MashMatrix
Organizational Unit Name (eg, section) []:.
Common Name (eg, YOUR name) []:mashmatrix
Email Address []:.
```

7. SSL�ؖ����𐶐����܂��B  
  openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt

8. �p�X���[�h��[mashmatrix20190226]�Ƃ��ăG���R�[�h���s���Ă���܂��B  
  openssl enc -aes-256-cbc -k mashmatrix20190226 -P -md sha1 -nosalt

```bash
�L�[��iv�����s����܂��B  
key=718687FBF0530D0FAD7BE7BAB10EB53B349651C74CB90F35D7BF4FD544325E51  
iv =76DCC1640468C2922F14DE0848F1B000
```

9. �����̃L�[���g����server.key���Í������܂��B�Í�������server.key.enc�͌�قǎg�p���܂��B  
  openssl enc -nosalt -aes-256-cbc -in server.key -out server.key.enc -base64 -K <key> -iv <iv>


## Salesforce CLI�̃C���X�g�[��

1. �����炩��_�E�����[�h�ł��܂��B(https://developer.salesforce.com/tools/sfdxcli)  
�R�}���h�v�����v�g�𗧂��グ�āA`sfdx force --help` �����s���ăR�}���h�����s�ł��邱�Ƃ��m�F���Ă��������B

2. Salesforce�̑g�D�ŁADev Hub��L�������Ă����܂��B

3. Dev Hub�����ɔF�؂��Ă���ꍇ�́A���̃R�}���h�ŊJ���܂��B  
  sfdx force:org:open -u DevHub

4. Dev Hub �g�D�ɂ܂����O�C�����Ă��Ȃ��ꍇ�̓��O�C�����܂��B  
  sfdx force:auth:web:login -d -a DevHub

5. �g�D�����X�g���܂��B  
  sfdx force:org:list

```bash
        === Orgs
            ALIAS   USERNAME          ORG ID              CONNECTED STATUS
        ������ �������������� ��������������������������������  ������������������������������������  ������������������������������������
        (D) DevHub  user@dh0425.org   00DB0000000Ifd5MAC  Connected
```

## �ڑ��A�v���P�[�V�����̍쐬

#### �ڑ��A�v���P�[�V�����̍쐬

1. [�ݒ�] ����A[�N�C�b�N����] �{�b�N�X�Ɂu�A�v���P�[�V�����}�l�[�W���v�Ɠ��͂��A[�A�v���P�[�V�����}�l�[�W��] ��I�����܂��B

2. [�V�K�ڑ��A�v���P�[�V����] ���N���b�N���܂��B

3. �ڑ��A�v���P�[�V�������Ǝ��g�̃��[���A�h���X����͂��܂��B  
    a) �ڑ��A�v���P�[�V������: <�A�v���P�[�V������>  
    b) �A���惁�[��: <���g�̃��[���A�h���X>

4. [OAuth �ݒ�̗L����] ���I���ɂ��܂��B

5. �R�[���o�b�N URL ����͂��܂��B  
    `http://localhost:1717/OauthRedirect`

6. [�f�W�^���������g�p] ���I���ɂ��܂��B

7. openssl�ō쐬����server.crt �t�@�C�����A�b�v���[�h����ɂ́A[�t�@�C����I��] ���N���b�N���܂��B

8. OAuth �͈͂ɂ́A���̍��ڂ�ǉ����܂��B  
    - �f�[�^�ւ̃A�N�Z�X�ƊǗ� (api)
    - ���[�U�ɑ����Ă��ł��v�������s (refresh_token�Aoffline_access)
    - Web �o�R�̃f�[�^�ւ̃A�N�Z�X��� (web)

9. [�ۑ�] ���N���b�N���܂��B

    **�d�v:** �R���V���[�}���͌�Ŏg�p���邽�ߖY�ꂸ�ɃR�s�[���Ă����܂��B

#### �|���V�[�̕ҏW

1. [�Ǘ�] ���N���b�N���܂��B

2. [�|���V�[��ҏW] ���N���b�N���܂��B

3. [OAuth �|���V�[] �Z�N�V������ [������Ă��郆�[�U] �ŁA[�Ǘ��҂����F�������[�U�͎��O���F�ς�] ��I�����āA[OK] ���N���b�N���܂��B

4. [�ۑ�] ���N���b�N���܂��B

#### �����Z�b�g�̍쐬

1. [�ݒ�] ����A[�N�C�b�N����] �{�b�N�X�Ɂu�����v�Ɠ��͂��A[�����Z�b�g] ��I�����܂��B

2. [�V�K] ���N���b�N���܂��B

3. [�\�����x��] ��<�����Z�b�g��>����͂��܂��B

4. [�ۑ�] ���N���b�N���܂��B

5. [�����Z�b�g��] | [���蓖�Ă̊Ǘ�] | [���蓖�Ă�ǉ�] ���N���b�N���܂��B

6. Dev Hub ���[�U���̉��ɂ���`�F�b�N�{�b�N�X���I���ɂ��āA[���蓖��] | [����] ���N���b�N���܂��B

7. �ڑ��A�v���P�[�V�����ɖ߂�܂��B  
    a) [�ݒ�] ����A[�N�C�b�N����] �{�b�N�X�Ɂu�A�v���P�[�V�����}�l�[�W���v�Ɠ��͂��A[�A�v���P�[�V�����}�l�[�W��] ��I�����܂��B 

    b) �A�v���P�[�V������ �̉��ɂ��郊�X�g���ڃh���b�v�_�E����� (���X�g���ڃh���b�v�_�E��) ���N���b�N���āA[�Ǘ�] ���N���b�N���܂��B  

    c) [�����Z�b�g] �Z�N�V�����ŁA[�����Z�b�g�̊Ǘ�] ���N���b�N���܂��B  

    d) [�����Z�b�g��] �̉��ɂ���`�F�b�N�{�b�N�X���I���ɂ��āA[�ۑ�] ���N���b�N���܂��B  

#### �ڑ��A�v���P�[�V�����̐ڑ��m�F

1. �R�}���h�v�����v�g����ȉ��̃R�}���h��1�s�œ��͂��܂��BSuccessfully���Ԃ��Ă�����JWT�F�؂̐ڑ��m�FOK�ł��B

	- ${CONSUMER_KEY}=�R���V���[�}�[�L�[
	- ${JWT_KEY_FILE}=server.key���t���p�X��
	- ${HUB_USERNAME}=Dev Hub�̃��[�U��

```bash
	sfdx force:auth:jwt:grant --clientid ${CONSUMER_KEY} --username ${HUB_USERNAME} --jwtkeyfile ${JWT_KEY_FILE} --setdefaultdevhubusername
```

## GitHub��CircleCI�̘A�g

1. Git�̃A�J�E���g��CircleCI�̘A�g���s���Ă��������B  
  CircleCi���ŁA[UserSettings] -> [AccountIntegrations]�ɂāAGitHub�Ƃ̘A�g���s���܂��B

2. [ADD PROJECTS] -> �Ώۃv���W�F�N�g��[Set Up Project]  

## CircleCI�Ɛڑ��A�v���P�[�V�����̘A�g

1. [Setting] -> [Project] �ɂāA�ΏۂƂȂ�v���W�F�N�g�̎��ԃA�C�R�����N���b�N���܂��B

2. [Environment Variables]��[Add Variable]�{�^������ȉ���4�̊��ϐ���ǉ����܂��B

    - HUB_CONSUMER_KEY: �쐬�����ڑ��A�v���̃R���V���[�}�L�[
    - HUB_SFDC_USER: DevHub�g�D�̃��[�U��
    - DECRYPTION_KEY: �O�̎菇�ō쐬�����������̂��߂�key
    - DECRYPTION_IV: �O�̎菇�ō쐬�����������̂��߂�iv

![CircleCi environment](img/environment.png)

## GitHub�ւ̃��\�[�X��Push�ƃe�X�g���s

1. �O�̎菇�ō쐬�����Í��������T�[�o�[�L�[(server.key.enc)�����|�W�g���� assets/ �Ɋi�[����Push���܂��B

2. ./circleci/config.yml�ŁA�e�X�g�̎��{����{���ʂ�GitHub�ւ�Push���s���Ă��܂��B

## CircleCI����GitHub�փe�X�g���ʂ�Push���邽�߂̃A�N�Z�X�L�[�ǉ�

1. CircleCI����e�X�g���ʂ�Git��Push����ɂ́AGit���|�W�g���ւ̏������݌������K�v�ƂȂ�܂��B  
CircleCi -> [�v���W�F�N�g] -> [�ݒ�] -> �����j���[[Checkout SSH keys] -> Add user key [Create and add ���|�W�g���� user key]�{�^���������܂��B  

2. ���̃{�^�����o�Ă��Ȃ��ꍇ�́AGit�̐ݒ�ŁuSSH and GPG keys�v�Ƃ������j���[������̂ŁASSH keys���m�F����B
read only�̃L�[�����o�^����Ă��Ȃ��ꍇ�́A��U�폜����CircleCI������SSH key��o�^���Ȃ����Ă��������B  

![CircleCi sshkey](img/sshkeys.png)


## �⑫

#### config.yml�ɂ���

1. Git���|�W�g���̃A�J�E���g�������ύX�ΏۂƂȂ�܂��B2�ӏ�����܂��̂œK�X���������Ă��������B  
 - git config user.email "hoge@example.com"
 - git config user.name "accountname"
 - git push origin master;
