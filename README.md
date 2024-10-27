# TFS Notify - Notification UI FiveM pour FIVEM

<p align="center">
  <img src="https://cdn.discordapp.com/attachments/1291112806451511369/1300131722381361152/FiveM_GTA_V_Logo.png?ex=671fb985&is=671e6805&hm=1ad9f041a278429449b639691945a5986bc0c61f6198aec86f1111ff5fd93734&" alt="Logo" width="300" height="100"/>
</p>


## 📜 Description

TFS Notify est un script de notification pour FiveM. Il utilise le système ESX pour afficher des notifications personnalisables en jeu. Le script propose des notifications standards, avancées et d'aide.

## 📝 Modification d'ESX

Pour utiliser les fonctions de TFS Notify avec ESX, ajoutez les modifications suivantes dans `es_extended/client/fonctions.lua` :

```lua
function ESX.ShowNotification(msg, couleurProgress)
    exports.TFS_notify:Send(msg, couleurProgress)
end

function ESX.ShowAdvancedNotification(title, subject, msg, couleurProgress, banner, timeout, icon)
    exports.TFS_notify:SendAdvanced(msg, subject, title, couleurProgress, banner, nil, nil, true, nil, icon)
end

function ESX.ShowHelpNotification(msg)
	AddTextEntry('esxHelpNotification', msg)
	BeginTextCommandDisplayHelp('esxHelpNotification')
	EndTextCommandDisplayHelp(0, false, true, -1)
end
```

## 🚀 Types de Notifications

### Commandes Client

Les notifications peuvent être déclenchées avec les commandes suivantes dans le client :

- **Notification Simple** : Affiche une notification avec du texte et une couleur.
  ```lua
  RegisterCommand('2', function()
      ESX.ShowNotification("Le Los Santos Custom est ~g~ouvert", "#5fa05d")
  end)
  ```

- **Notification de Fermeture** : Affiche une notification indiquant la fermeture.
  ```lua
  RegisterCommand('3', function()
      ESX.ShowNotification("Le Los Santos Custom est ~r~fermer", "#FF0000")
  end)
  ```

- **Notification Avancée** : Affiche une notification détaillée avec un titre, un sujet, et une icône.
  ```lua
  RegisterCommand('1', function()
      ESX.ShowAdvancedNotification(
          '~p~Appel d\'urgence - 2061',
          '~p~Central',
          "~p~Localisation:~s~\n<b><span style='font-weight: 500;'>Groove Street (15m)</span></b>\n~p~Infos:~s~\n<b><span style='font-weight: 500'>Tire à feux</span></b>",
          '#b19bd9',
          'call',
          7
      )
  end)
  ```

### Commandes Serveur

Pour déclencher une notification depuis le serveur :

```lua
RegisterCommand('3', function()
    TriggerClientEvent('esx:showNotification', _src, "Le Los Santos Custom est ~r~fermer", "#FF0000")
end)
```

## 💻 Installation

1. Téléchargez le script depuis le [lien de téléchargement](https://github.com/tifiouse-root/TFS_NOTIFY/archive/refs/heads/main.zip).
2. Décompressez le fichier et placez le dossier `tfs_notify` dans votre dossier `resources` de votre serveur FiveM.
3. Ajoutez `ensure tfs_notify` à votre fichier `server.cfg`.

## 📜 Configuration

Le fichier `config.lua` contient les paramètres de configuration de base. Modifiez les options pour ajuster les couleurs, les icônes et les durées des notifications selon vos préférences.

### 📜 Exemples de configuration :

```lua
Config.Timeout          = 8000          -- Remplacé par le paramètre `timeout`
Config.Position         = "bottomleft"  -- Remplacé par le paramètre `position`
Config.Progress         = true          -- Remplacé par le paramètre `progress`
Config.Theme            = "default"     -- Remplacé par le paramètre `theme`
Config.Queue            = 5             -- Nombre de notifications à afficher avant de les mettre en file d'attente
Config.Stacking         = true          -- Empiler les notifications
Config.ShowStackedCount = true          -- Afficher le nombre de notifications empilées
Config.AnimationOut     = "fadeOut"     -- Animation de sortie - 'fadeOut', 'fadeOutLeft', 'flipOutX', 'flipOutY', 'bounceOutLeft', 'backOutLeft', 'slideOutLeft', 'zoomOut', 'zoomOutLeft'
Config.AnimationTime    = 800           -- Intervalle d'animation d'entrée/sortie
Config.FlashCount       = 5             -- Nombre de clignotements de la notification
Config.FlashType        = "flash"       -- Type de clignotement de la notification
Config.SoundFile        = false         -- Fichier audio stocké dans ui/audio pour le son de notification. Laisser sur false pour désactiver.
Config.SoundVolume      = 0.4           -- Volume du son de notification, de 0.0 à 1.0
```

## License

Ce projet est sous licence [MIT](#).
```

# Licence MIT

Copyright (c) [2024] [Tifiouse]

## Conditions de la Licence

Par la présente, il est accordé, sans frais, à toute personne obtenant une copie de ce script (TFS_FUEL) et des fichiers de documentation associés, le droit de traiter le Script sans restriction, y compris, sans limitation, le droit de l'utiliser, de le copier, de le modifier, de le fusionner, de le publier, de le distribuer, de le sous-licencier et/ou de vendre des copies du Script, et de permettre aux personnes à qui le Script est fourni de le faire, sous réserve des conditions suivantes :

1. Attribution : L'avis de copyright ci-dessus et cet avis de permission doivent être inclus dans toutes les copies ou parties substantielles du Script.

2. Utilisation : Vous pouvez utiliser ce script dans des projets personnels ou commerciaux tant que vous respectez les conditions de cette licence.

3. Exclusion de garantie : LE SCRIPT EST FOURNI "EN L'ÉTAT", SANS GARANTIE D'AUCUNE SORTE, EXPRESSE OU IMPLICITE, Y COMPRIS MAIS SANS S'Y LIMITER AUX GARANTIES DE COMMERCIALISATION, D'ADÉQUATION À UN USAGE PARTICULIER ET DE NON-CONTREFAÇON. EN AUCUN CAS, L'AUTEUR OU LES TITULAIRES DU DROIT D'AUTEUR NE POURRONT ÊTRE TENUS RESPONSABLES DE QUELQUE RECLAMATION, DOMMAGES OU AUTRES RESPONSABILITÉS, QUE CE SOIT DANS UNE ACTION EN CONTRAT, EN DÉLIT OU AUTRE, DÉCOULANT DE OU EN LIEN AVEC LE SCRIPT OU L'UTILISATION OU D'AUTRES TRAITEMENTS DANS LE SCRIPT.

```
