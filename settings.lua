Settings = {}

Settings.Framework = 'esx' -- ( esx, qb, vrp )

Settings.BossSettings = {
    bossPed = "g_m_m_armboss_01",
    bossCoords = vector3(-440.83, 6133.91, 30.47),
    bossHeading = 360.0,
}

Settings.Ox = { 
  target = false,
}

Settings.RobbTime = 300
Settings.RobbLocation = vector3(-2731.46, 6622.14, 26.42)
Settings.BlipText = 'Oil Rig'
Settings.PoliceJob = 'police'
Settings.MinimalPolice = 5

Settings.Items = {
  {
    name = "diamond",
    count = math.random(1, 3)
  },
  {
    name = "gold",
    count = math.random(270, 370)
  },
}


Settings.Securities = { 
  [1] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2712.764, 6613.69, 21.74),
    heading = 276.1,
  },

  [2] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2712.72, 6609.456, 21.74),
    heading = 263.2,
  },

  [3] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2718.772, 6583.026, 21.74),
    heading = 265.1,
  },

  [4] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2710.941, 6679.22, 25.96),
    heading = 265.0,
  },

  [5] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2709.744, 6582.597, 28.83),
    heading = 281.49,
  },

  [6] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2733.973, 6588.39, 21.74),
    heading = 270.1,
  },

  [7] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2713.32, 6586.84, 15.03),
    heading = 260.1,
  },

  [8] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2719.822, 6598.6, 15.1),
    heading = 273.1,
  },

  [9] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2733.803, 6621.912, 26.42),
    heading = 183.1,
  },

  [10] = {
    model = 's_m_m_security_01',
    gun = 'WEAPON_CARBINERIFLE',
    coords = vector3(-2731.099, 6621.83, 26.42),
    heading = 176.1,
  },

}

Settings.Strings = {
  ['press_e_to_talk'] = 'Press E to talk to the boss',
  ['talking'] = 'Talking to the Boss',
  ['already_robbing'] = 'Someone is already doing this heist',
  ['no_cops'] = 'Not enough police in the city',
  ['info'] = 'You need to go to the rig,\nkill the security and rob the rig safe',
  ['to_accept'] = 'To accept the mission',
  ['to_deny'] = 'To deny the mission',
  ['accept'] = 'You accepted the mission, now go and do it.',
  ['deny'] = 'You denied the mission.',
  ['located'] = 'Mission is located on the map, go and do it!',
  ['dead'] = 'You died so the mission has been aborted.',
  ['all_peds_dead'] = 'Security is dead, go and rob the Rig in the office!',
  ['press_e_to_robb'] = 'Press E to start the robbery.',
  ['started_robbery'] = 'You started the robbery, do not stray too far!',
  ['time_left'] = 'Time Left',
  ['too_far'] = 'You went too far and aborted the robbery.',
  ['police_message'] = 'There is a robbery in progress at the Oil Company!',
  ['robb_stopped'] = 'The robbers have stopped the Oil Company robbery',
  ['robb_ended'] = 'The robbers have successfully robbed the oil company',
  ['complete'] = 'You have successfully robbed the Oil Company.'  
}