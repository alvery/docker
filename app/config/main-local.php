<?php
// local db settings
return [
    'components' => [
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=mysql;dbname=dev_redlinemom',
            'username' => 'root',
            'password' => 'root',
            'charset' => 'utf8',
            'enableSchemaCache' => false,
            'schemaCacheDuration' => 3600,
            'on afterOpen' => function($event) {
                $event->sender->createCommand("SET time_zone = '+0:00'")->execute(); // set MySQL timezone UTC by default
            }
        ],
    ]
];
